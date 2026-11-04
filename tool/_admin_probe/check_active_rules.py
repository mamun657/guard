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
    releases = api_get(f"{RULES_API}/projects/{PROJECT_ID}/releases")
    print("RELEASES_STATUS", releases.status_code)
    if releases.status_code != 200:
        print(releases.text[:800])
        return 1
    for release in releases.json().get("releases", []):
        print("RELEASE", release.get("name"), "->", release.get("rulesetName"),
              release.get("createTime"))

    listing = api_get(f"{RULES_API}/projects/{PROJECT_ID}/rulesets")
    rulesets = {r["name"]: r.get("createTime") for r in listing.json().get("rulesets", [])}
    print("\nRULESETS:")
    for name, created in rulesets.items():
        print(" ", name, created)

    active_name = None
    for release in releases.json().get("releases", []):
        if release.get("name", "").endswith("cloud.firestore"):
            active_name = release.get("rulesetName")
    if not active_name:
        print("NO_ACTIVE_RELEASE")
        return 2
    print("\nACTIVE RULESET:", active_name, rulesets.get(active_name))

    detail = api_get(f"{RULES_API}/{active_name}")
    for entry in detail.json().get("source", {}).get("files", []):
        content = entry.get("content", "")
        # Print only the sections that matter for approval and invitation lookup.
        for marker in ("match /familyInvitations",
                       "match /users/{ownerUid}",
                       "match /approvedViewers",
                       "match /incomingRequests",
                       "match /familyViewerAccess"):
            index = content.find(marker)
            print("\n" + "=" * 70)
            print("SECTION:", marker, "at", index)
            print("=" * 70)
            if index >= 0:
                print(content[index:index + 2600])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
