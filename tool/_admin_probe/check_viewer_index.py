import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.firebase_gateway import firestore_client  # noqa: E402

SON_UID = "ZwKmr2os7UfLmoToXvph51JexwY2"
FATHER_UID = "hQTN84bXKARVkndmlfmwXrCpH3D2"
DIDAR_UID = "5GqoAjwIkwT8z1htU6JW8Io0Ea52"
FATHER_DEVICE = "336B19FF95D362A466A0793CE1E4E31B"


def main() -> int:
    client = firestore_client()

    print("=== son viewer access index (subcollection direct) ===")
    for grant in (
        client.collection("familyViewerAccess").document(SON_UID)
        .collection("grants").stream()
    ):
        print(" ", grant.id, grant.to_dict())

    print("=== familyViewerAccess top-level doc existence ===")
    for uid in (SON_UID, FATHER_UID, DIDAR_UID):
        doc = client.collection("familyViewerAccess").document(uid).get()
        print(" ", uid, "exists=", doc.exists, doc.to_dict())

    print("=== user profiles ===")
    for uid in (SON_UID, FATHER_UID, DIDAR_UID):
        doc = client.collection("users").document(uid).get()
        data = doc.to_dict() or {}
        print(" ", uid, "exists=", doc.exists,
              "displayName=", repr(data.get("displayName")),
              "email=", repr(data.get("email")),
              "phone=", repr(data.get("phoneNumber")),
              "keys=", sorted(data.keys()))

    print("=== father incoming request (TEGA) ===")
    req = (
        client.collection("users").document(FATHER_UID)
        .collection("devices").document(FATHER_DEVICE)
        .collection("incomingRequests").document(SON_UID).get()
    )
    print(" exists=", req.exists, req.to_dict())

    print("=== son status/location for father device ===")
    for sub in ("status", "location"):
        doc = (
            client.collection("users").document(FATHER_UID)
            .collection("devices").document(FATHER_DEVICE)
            .collection(sub).document("current").get()
        )
        print(" ", sub, "exists=", doc.exists, doc.to_dict())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
