import json
import os
from pathlib import Path

from probe_scopes import CLOUD_PLATFORM, PROJECT_ID, user_credentials

IAM = "https://iam.googleapis.com/v1"
SA_ID = "amarguard-backend"
DISPLAY_NAME = "AmarGuard CareSignal Backend"
KEY_DIR = Path(os.path.expanduser("~")) / ".amarguard"
KEY_PATH = KEY_DIR / "backend-service-account.json"


def api(method, url, body=None):
    import requests

    creds = user_credentials()
    headers = {
        "Authorization": f"Bearer {creds.token}",
        "Content-Type": "application/json",
    }
    response = requests.request(method, url, headers=headers, json=body, timeout=60)
    return response


def find_service_account():
    response = api("GET", f"{IAM}/projects/{PROJECT_ID}/serviceAccounts")
    if response.status_code != 200:
        print("LIST_SA_STATUS", response.status_code, response.text[:400])
        return None
    for account in response.json().get("accounts", []):
        if account.get("email", "").startswith(f"{SA_ID}@"):
            return account
    return None


def main():
    KEY_DIR.mkdir(parents=True, exist_ok=True)

    account = find_service_account()
    if account is None:
        response = api(
            "POST",
            f"{IAM}/projects/{PROJECT_ID}/serviceAccounts",
            {
                "accountId": SA_ID,
                "serviceAccount": {
                    "displayName": DISPLAY_NAME,
                    "description": "Server-side identity for the AmarGuard CareSignal FastAPI backend.",
                },
            },
        )
        print("CREATE_SA_STATUS", response.status_code)
        if response.status_code not in (200, 201):
            print("CREATE_SA_ERROR", response.text[:600])
            return 1
        account = response.json()
    else:
        print("SA_EXISTS")

    name = account["name"]
    email = account["email"]
    print("SA_NAME", name)

    roles = [
        "roles/firebase.admin",
        "roles/datastore.user",
        "roles/iam.serviceAccountTokenCreator",
    ]
    for role in roles:
        response = api(
            "POST",
            f"{IAM}/projects/{PROJECT_ID}:setIamPolicy",
            {"policy": {"bindings": [{"role": role, "members": [f"serviceAccount:{email}"]}]}},
        )
        print("BIND", role, response.status_code, response.text[:300] if response.status_code not in (200, 201) else "")

    response = api("POST", f"{IAM}/{name}/keys", {"keyAlgorithm": "KEY_ALG_RSA_2048"})
    print("CREATE_KEY_STATUS", response.status_code)
    if response.status_code not in (200, 201):
        print("CREATE_KEY_ERROR", response.text[:600])
        return 1
    key = response.json()
    private_key = key.get("privateKey") or (key.get("privateKeyData") or "")

    service_account = {
        "type": "service_account",
        "project_id": PROJECT_ID,
        "private_key_id": key["name"].split("/")[-1],
        "private_key": private_key,
        "client_email": email,
        "client_id": str(key.get("clientId", "")),
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": f"https://www.googleapis.com/robot/v1/metadata/x509/{email}",
    }
    KEY_PATH.write_text(json.dumps(service_account, indent=2), encoding="utf-8")
    os.chmod(KEY_PATH, 0o600)
    print("KEY_PATH", KEY_PATH)
    print("SA_EMAIL", email)
    print("PROJECT_ID", PROJECT_ID)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
