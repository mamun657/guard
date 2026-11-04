import json
import os
from pathlib import Path

STORE = Path(os.path.expanduser("~")) / ".config" / "configstore" / "firebase-tools.json"
PROJECT_ID = "guard-ab0d3"
CLOUD_PLATFORM = "https://www.googleapis.com/auth/cloud-platform"


def load_store():
    return json.loads(STORE.read_text(encoding="utf-8"))


def user_credentials(scopes=(CLOUD_PLATFORM,)):
    from google.auth.transport.requests import Request
    from google.oauth2.credentials import Credentials

    data = load_store()
    tokens = data["tokens"]
    creds = Credentials(
        token=None,
        refresh_token=tokens["refresh_token"],
        token_uri="https://oauth2.googleapis.com/token",
        client_id=data["user"]["azp"],
        client_secret="j9iVZfS8kkCEFUPaAeJV0sAi",
        scopes=list(scopes),
    )
    creds.refresh(Request())
    return creds


def main():
    from google.cloud import firestore

    creds = user_credentials()
    print("TOKEN_OK scopes=", creds.scopes)
    client = firestore.Client(project=PROJECT_ID, credentials=creds)
    docs = list(client.collection("users").limit(20).stream())
    print("USERS_COUNT=", len(docs))
    for d in docs:
        data = d.to_dict() or {}
        print("USER", d.id[:6] + "..." + d.id[-4:], data.get("displayName"), data.get("email"))


if __name__ == "__main__":
    main()
