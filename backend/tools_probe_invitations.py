import os

from app.firebase_gateway import firestore_client

client = firestore_client()
db = client

target_raw = "BFK-X4PQ-1RKJ-KC3G-3ZV0-0N2P"
alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
normalized = "".join(c for c in target_raw.upper() if c in alphabet)
print("entered code :", target_raw)
print("normalized   :", normalized, "len", len(normalized))

print("\n--- direct doc get by normalized id ---")
snap = db.collection("familyInvitations").doc(normalized).get()
print("exists:", snap.exists)
if snap.exists:
    print(snap.to_dict())

print("\n--- doc get by normalized id with leading 0 ---")
alt = "0" + normalized
snap = db.collection("familyInvitations").doc(alt).get()
print("exists:", snap.exists)
if snap.exists:
    for key, value in (snap.to_dict() or {}).items():
        print(f"   {key} = {value!r}")

print("\n--- scan all invitations for a matching code field ---")
docs = list(db.collection("familyInvitations").get())
print("total invitations:", len(docs))
for doc in docs:
    data = doc.to_dict() or {}
    code_field = str(data.get("code") or data.get("invitationCode") or "")
    if normalized in (doc.id, code_field.upper().replace("-", ""), alt):
        print("MATCH doc.id:", doc.id)
        for key, value in data.items():
            print(f"   {key} = {value!r}")

print("\n--- all invitation doc ids (len, id, status, ownerUid) ---")
for doc in docs:
    data = doc.to_dict() or {}
    print(
        f"   len={len(doc.id):2d} id={doc.id} status={data.get('status')} "
        f"owner={data.get('ownerUid')} device={data.get('deviceId')}"
    )
