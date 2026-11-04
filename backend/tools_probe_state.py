import json
from datetime import datetime, timezone

from app.firebase_gateway import firestore_client

ALPHABET = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"


def normalize(value: str) -> str:
    upper = value.upper()
    return "".join(c for c in upper if c in ALPHABET)


def fmt(token: str) -> str:
    normalized = normalize(token)
    groups = [normalized[i : i + 4] for i in range(0, len(normalized), 4)]
    return "-".join(groups)


db = firestore_client()

entered = "BFK-X4PQ-1RKJ-KC3G-3ZV0-0N2P"
local = "TEGA-1V20-DPQY-H826-VYF3-880S"

print("=== entered code ===")
print("entered:", entered, "-> normalized:", normalize(entered), "len", len(normalize(entered)))
print("local  :", local, "-> normalized:", normalize(local), "len", len(normalize(local)))

print("\n=== invitation documents of interest ===")
for raw in (entered, local):
    token = normalize(raw)
    for candidate in (token, "0" + token):
        snap = db.collection("familyInvitations").document(candidate).get()
        if not snap.exists:
            continue
        data = snap.to_dict() or {}
        print(f"\n--- doc id={snap.id} (looked up as {candidate}) ---")
        for key in sorted(data):
            value = data[key]
            if key in {"ownerUid", "viewerUid"}:
                value = str(value)[:8] + "..."
            print(f"   {key} = {value!r}")
        print("   subcollections:", [c.id for c in snap.reference.collections()])
        reqs = snap.reference.collection("requests").get()
        for req in reqs:
            rd = req.to_dict() or {}
            print(f"     request/{req.id}: status={rd.get('status')} viewer={str(rd.get('viewerUid'))[:8]}... rel={rd.get('relationship')} name={rd.get('viewerDisplayName')!r} email={rd.get('viewerEmail')!r}")

print("\n=== all invitations (summary) ===")
docs = list(db.collection("familyInvitations").get())
print("total:", len(docs))
for doc in docs:
    data = doc.to_dict() or {}
    exp = data.get("expiresAt")
    print(
        f"   len={len(doc.id):2d} id={doc.id} status={data.get('status'):9s} "
        f"owner={str(data.get('ownerUid'))[:8]} device={str(data.get('deviceId'))[:10]} "
        f"expires={exp} code={data.get('code')!r}"
    )

print("\n=== users / devices / incomingRequests ===")
for user_doc in db.collection("users").get():
    uid = user_doc.id
    profile = user_doc.to_dict() or {}
    print(f"\nUSER {uid[:8]}... displayName={profile.get('displayName')!r} email={profile.get('email')!r} phone={profile.get('phoneNumber')!r}")
    for dev in user_doc.reference.collection("devices").get():
        dd = dev.to_dict() or {}
        print(f"   device {dev.id[:12]}... nickname={dd.get('nickname')!r} sharingState={dd.get('sharingState')!r} ownerUid={str(dd.get('ownerUid'))[:8]}")
        inc = dev.reference.collection("incomingRequests").get()
        for req in inc:
            rd = req.to_dict() or {}
            print(f"      incoming/{req.id[:8]}... status={rd.get('status')} invitationId={rd.get('invitationId')} name={rd.get('viewerDisplayName')!r} email={rd.get('viewerEmail')!r} rel={rd.get('relationship')!r} deviceId={rd.get('deviceId')!r}")
        appr = dev.reference.collection("approvedViewers").get()
        for g in appr:
            gd = g.to_dict() or {}
            print(f"      approved/{g.id[:8]}... active={gd.get('active')} invitationId={gd.get('invitationId')} name={gd.get('viewerDisplayName')!r} email={gd.get('viewerEmail')!r} rel={gd.get('relationship')!r}")

print("\n=== familyViewerAccess ===")
for v in db.collection("familyViewerAccess").get():
    print(f"VIEWER {v.id[:8]}...")
    for g in v.reference.collection("grants").get():
        gd = g.to_dict() or {}
        print(f"   grant/{g.id} owner={str(gd.get('ownerUid'))[:8]} device={gd.get('deviceId')!r} rel={gd.get('relationship')!r} name={gd.get('ownerDisplayName')!r} alias={gd.get('alias')!r}")

print("\n=== helpRequests ===")
for r in db.collection("helpRequests").get():
    rd = r.to_dict() or {}
    print(f"   {r.id} sender={str(rd.get('senderUid'))[:8]} recipient={str(rd.get('recipientUid'))[:8]} status={rd.get('status')}")
