import json
import os
from pathlib import Path

STORE = Path(os.path.expanduser("~")) / ".config" / "configstore" / "firebase-tools.json"
PROJECT_ID = "guard-ab0d3"


def build_credentials():
    from firebase_admin import credentials

    data = json.loads(STORE.read_text(encoding="utf-8"))
    tokens = data["tokens"]
    return credentials.RefreshToken(
        {
            "type": "authorized_user",
            "client_id": data["user"]["azp"],
            "client_secret": "j9iVZfS8kkCEFUPaAeJV0sAi",
            "refresh_token": tokens.get("refresh_token"),
        }
    )


def get_db():
    import firebase_admin
    from firebase_admin import firestore as admin_firestore

    if not firebase_admin._apps:
        firebase_admin.initialize_app(
            build_credentials(),
            options={"projectId": PROJECT_ID},
        )
    return admin_firestore.client()


def uid_label(uid):
    if not uid:
        return "<empty>"
    return f"{uid[:6]}...{uid[-4:]}(len={len(uid)})"


def main():
    db = get_db()

    print("=== users ===")
    for doc in db.collection("users").stream():
        data = doc.to_dict() or {}
        print(
            "USER",
            uid_label(doc.id),
            "displayName=", data.get("displayName"),
            "email=", data.get("email"),
            "hasPhone=", bool(data.get("phoneNumber")),
        )
        for d in doc.reference.collection("devices").stream():
            dd = d.to_dict() or {}
            print("   DEVICE", d.id, "owner=", uid_label(str(dd.get("ownerUid"))),
                  "sharingState=", dd.get("sharingState"), "nickname=", dd.get("nickname"))
            for g in d.reference.collection("approvedViewers").stream():
                gd = g.to_dict() or {}
                print("      APPROVED_VIEWER viewer=", uid_label(g.id),
                      "active=", gd.get("active"), "rel=", gd.get("relationship"),
                      "ownerUid=", uid_label(str(gd.get("ownerUid"))),
                      "deviceId=", gd.get("deviceId"),
                      "name=", gd.get("viewerDisplayName"))
            for r in d.reference.collection("incomingRequests").stream():
                rd = r.to_dict() or {}
                print("      INCOMING viewer=", uid_label(r.id), "status=", rd.get("status"),
                      "rel=", rd.get("relationship"), "invitation=", str(rd.get("invitationId"))[:8])
            loc = d.reference.collection("location").document("current").get()
            if loc.exists:
                ld = loc.to_dict() or {}
                print("      LOCATION lat=", round(ld.get("latitude", 0), 4),
                      "lng=", round(ld.get("longitude", 0), 4), "acc=", ld.get("accuracy"),
                      "capturedAt=", ld.get("capturedAt"), "syncedAt=", ld.get("syncedAt"))
            st = d.reference.collection("status").document("current").get()
            if st.exists:
                sd = st.to_dict() or {}
                print("      STATUS", {k: sd.get(k) for k in
                                     ("sharingState", "lastSuccessfulUpload", "batteryLevel",
                                      "isCharging", "batteryObservedAt")})

    print("=== familyViewerAccess (all) ===")
    for v in db.collection("familyViewerAccess").stream():
        print("VIEWER", uid_label(v.id))
        for g in v.reference.collection("grants").stream():
            gd = g.to_dict() or {}
            print("   GRANT doc=", g.id, "owner=", uid_label(str(gd.get("ownerUid"))),
                  "device=", gd.get("deviceId"), "rel=", gd.get("relationship"),
                  "name=", gd.get("ownerDisplayName"))

    print("=== familyInvitations ===")
    for inv in db.collection("familyInvitations").stream():
        d = inv.to_dict() or {}
        print("INV", inv.id[:8] + "...", "owner=", uid_label(str(d.get("ownerUid"))),
              "device=", d.get("deviceId"), "status=", d.get("status"),
              "expiresAt=", d.get("expiresAt"))
        for r in inv.reference.collection("requests").stream():
            rd = r.to_dict() or {}
            print("   REQUEST viewer=", uid_label(r.id), "status=", rd.get("status"),
                  "rel=", rd.get("relationship"), "owner=", uid_label(str(rd.get("ownerUid"))))

    print("=== helpRequests ===")
    for hr in db.collection("helpRequests").stream():
        d = hr.to_dict() or {}
        print("HELP", hr.id, "sender=", uid_label(str(d.get("senderUid"))),
              "recipient=", uid_label(str(d.get("recipientUid"))),
              "status=", d.get("status"), "device=", d.get("senderDeviceId"),
              "requestedAt=", d.get("requestedAt"))


if __name__ == "__main__":
    main()
