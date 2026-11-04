import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.firebase_gateway import firestore_client  # noqa: E402


def main() -> int:
    client = firestore_client()
    print("=== pending incoming requests ===")
    for user_doc in client.collection("users").stream():
        uid = user_doc.id
        profile = user_doc.to_dict() or {}
        print("USER", profile.get("displayName"), "|", profile.get("email"), "| uid", uid)
        for device in user_doc.reference.collection("devices").stream():
            ddata = device.to_dict() or {}
            print("  DEVICE", device.id, "state=", ddata.get("sharingState"), "nick=", ddata.get("nickname"))
            for req in device.reference.collection("incomingRequests").stream():
                rdata = req.to_dict() or {}
                print("    INCOMING viewer_uid=", req.id)
                print("      keys=", sorted(rdata.keys()))
                print("      invitationId=", repr(rdata.get("invitationId")))
                print("      deviceId=", repr(rdata.get("deviceId")))
                print("      status=", rdata.get("status"))
                print("      viewerDisplayName=", repr(rdata.get("viewerDisplayName")))
                print("      viewerEmail=", repr(rdata.get("viewerEmail")))
                print("      relationship=", repr(rdata.get("relationship")))
                print("      requestedAt=", rdata.get("requestedAt"))
            for grant in device.reference.collection("approvedViewers").stream():
                gdata = grant.to_dict() or {}
                print("    GRANT viewer_uid=", grant.id, "active=", gdata.get("active"),
                      "invitationId=", repr(gdata.get("invitationId")),
                      "name=", repr(gdata.get("viewerDisplayName")))

    print("=== familyViewerAccess ===")
    for viewer in client.collection("familyViewerAccess").stream():
        print("VIEWER", viewer.id)
        for grant in viewer.reference.collection("grants").stream():
            gdata = grant.to_dict() or {}
            print("   GRANT doc=", grant.id, "owner=", gdata.get("ownerUid"),
                  "device=", gdata.get("deviceId"), "name=", repr(gdata.get("ownerDisplayName")))

    print("=== invitation request docs (full) ===")
    for inv in client.collection("familyInvitations").stream():
        idata = inv.to_dict() or {}
        requests = list(inv.reference.collection("requests").stream())
        if not requests:
            continue
        print("INV", inv.id, "status=", idata.get("status"), "expiresAt=", idata.get("expiresAt"))
        print("   ownerUid=", idata.get("ownerUid"), "deviceId=", idata.get("deviceId"))
        for req in requests:
            rdata = req.to_dict() or {}
            print("   REQ viewer=", req.id, "status=", rdata.get("status"))
            print("       invitationId=", repr(rdata.get("invitationId")))
            print("       keys=", sorted(rdata.keys()))
            print("       displayName=", repr(rdata.get("viewerDisplayName")),
                  "email=", repr(rdata.get("viewerEmail")),
                  "rel=", repr(rdata.get("relationship")))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
