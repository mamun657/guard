import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from probe_scopes import user_credentials  # noqa: E402

PROJECT_ID = "guard-ab0d3"
RULES_API = "https://firebaserules.googleapis.com/v1"


def api_get(url):
    import requests

    creds = user_credentials()
    response = requests.get(
        url,
        headers={"Authorization": f"Bearer {creds.token}"},
        timeout=60,
    )
    return response


def main() -> int:
    listing = api_get(f"{RULES_API}/projects/{PROJECT_ID}/rulesets")
    print("LIST_STATUS", listing.status_code)
    if listing.status_code != 200:
        print(listing.text[:800])
        return 1
    payload = listing.json()
    rulesets = payload.get("rulesets", [])
    print("RULESET_COUNT", len(rulesets))
    for ruleset in rulesets:
        print("  ", ruleset.get("name"), ruleset.get("createTime"))

    if not rulesets:
        print("NO_DEPLOYED_RULESET")
        return 2
    ruleset_name = rulesets[0]["name"]
    detail = api_get(f"{RULES_API}/{ruleset_name}")
    print("DETAIL_STATUS", detail.status_code)
    if detail.status_code != 200:
        print(detail.text[:800])
        return 1
    body = detail.json()
    source = body.get("source", {}).get("files", [])
    for entry in source:
        content = entry.get("content", "")
        print("=" * 70)
        print("FILE:", entry.get("name"), "len", len(content))
        print("=" * 70)
        print(content)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
