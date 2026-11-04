from app.firebase_gateway import firestore_client

db = firestore_client()

inv = db.collection("familyInvitations").document("TEGA1V20DPQYH826VYF3880S").get()
owner_uid = (inv.to_dict() or {}).get("ownerUid")
device_id = (inv.to_dict() or {}).get("deviceId")

user_doc = db.collection("users").document(owner_uid).get()
print("users/{owner} exists:", user_doc.exists, "id:", user_doc.id)
if user_doc.exists:
    print("  profile:", user_doc.to_dict())

dev_ref = db.collection("users").document(owner_uid).collection("devices").document(device_id)


def dump(title, ref):
    print(f"\n--- {title} ---")
    for doc in ref.get():
        print("  doc id:", doc.id)
        for key, value in sorted((doc.to_dict() or {}).items()):
            print(f"     {key} = {value!r}")


dump("incomingRequests", dev_ref.collection("incomingRequests"))
dump("approvedViewers", dev_ref.collection("approvedViewers"))
dump("status", dev_ref.collection("status"))
dump("location", dev_ref.collection("location"))

print("\n--- requests under TEGA invitation ---")
for req in inv.reference.collection("requests").get():
    print("  request doc:", req.id)
    for key, value in sorted((req.to_dict() or {}).items()):
        print(f"     {key} = {value!r}")

print("\n--- familyViewerAccess ---")
for v in db.collection("familyViewerAccess").list_documents():
    print("  viewer:", v.id)
    for g in v.collection("grants").list_documents():
        print("     grant:", g.id, "->", g.get().to_dict())

print("\n--- helpRequests ---")
for r in db.collection("helpRequests").list_documents():
    print("  ", r.id, "->", r.get().to_dict())

print("\n--- mamun profile (viewer) ---")
mamun = db.collection("users").document("hQTN84bXKARVkndmlfmwXrCpH3D2").get()
print("  exists:", mamun.exists, mamun.to_dict())
