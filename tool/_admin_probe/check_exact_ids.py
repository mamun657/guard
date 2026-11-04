import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "backend"))

from app.firebase_gateway import firestore_client  # noqa: E402

MAMUN_UID = "hQTN84bXKARVkndmlfmwXrCpH3D2"
MAMUN_DEVICE = "336B19FF95D362A466A0793CE1E4E31B"


def main() -> int:
    client = firestore_client()

    print("=== invitation doc id lengths ===")
    for inv in client.collection("familyInvitations").stream():
        print(len(inv.id), repr(inv.id), (inv.to_dict() or {}).get("status"))

    print("=== targeted lookup for the entered code ===")
    for candidate in (
        "BFKX4PQ1RKJKC3G3ZV00N2P",
        "0BFKX4PQ1RKJKC3G3ZV00N2P",
        "TEGA1V20DPQYH826VYF3880S",
    ):
        snap = client.collection("familyInvitations").document(candidate).get()
        print(repr(candidate), "len", len(candidate), "exists", snap.exists,
              (snap.to_dict() or {}).get("status") if snap.exists else None)

    print("=== user profile for the father account ===")
    profile = client.collection("users").document(MAMUN_UID).get()
    print("users/%s exists=%s data=%s" % (MAMUN_UID, profile.exists, profile.to_dict()))

    print("=== father device doc ===")
    device = (
        client.collection("users").document(MAMUN_UID)
        .collection("devices").document(MAMUN_DEVICE).get()
    )
    print("device exists=%s data=%s" % (device.exists, device.to_dict()))

    print("=== father incoming requests ===")
    for req in (
        client.collection("users").document(MAMUN_UID)
        .collection("devices").document(MAMUN_DEVICE)
        .collection("incomingRequests").stream()
    ):
        print(req.id, req.to_dict())

    print("=== father approved viewers ===")
    for grant in (
        client.collection("users").document(MAMUN_UID)
        .collection("devices").document(MAMUN_DEVICE)
        .collection("approvedViewers").stream()
    ):
        print(grant.id, grant.to_dict())

    print("=== father viewer access index ===")
    for grant in (
        client.collection("familyViewerAccess").document(MAMUN_UID)
        .collection("grants").stream()
    ):
        print(grant.id, grant.to_dict())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
