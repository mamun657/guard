import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.firebase_gateway import firestore_client, get_firebase_app  # noqa: E402


def main() -> int:
    credential_path = os.getenv("FIREBASE_CREDENTIALS_PATH", "")
    print("credential_path_set:", bool(credential_path))
    app = get_firebase_app()
    print("project_id:", app.project_id)
    client = firestore_client()
    print("client_type:", type(client).__name__)
    docs = list(client.collection("users").limit(3).stream())
    print("users_sampled:", len(docs))
    for doc in docs:
        data = doc.to_dict() or {}
        print("  uid_len:", len(doc.id), "displayName:", data.get("displayName"))
    invitations = list(client.collection("familyInvitations").limit(20).stream())
    print("invitations:", len(invitations))
    for doc in invitations:
        data = doc.to_dict() or {}
        print("  doc_id:", doc.id)
        print("   status:", data.get("status"), "device:", data.get("deviceId"))
        print("   expiresAt:", data.get("expiresAt"), "owner_len:", len(str(data.get("ownerUid") or "")))
        print("   ownerDisplayName:", data.get("ownerDisplayName"))
        for request in doc.reference.collection("requests").stream():
            rdata = request.to_dict() or {}
            print("    request viewer_len:", len(request.id), "status:", rdata.get("status"),
                  "displayName:", rdata.get("viewerDisplayName"), "email:", rdata.get("viewerEmail"),
                  "rel:", rdata.get("relationship"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
