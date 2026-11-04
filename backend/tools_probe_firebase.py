import traceback

import firebase_admin
from firebase_admin import firestore as admin_firestore

print("firebase_admin version:", firebase_admin.__version__)
print("has client attr:", hasattr(admin_firestore, "client"))

try:
    from app.firebase_gateway import firestore_client, get_firebase_app

    app = get_firebase_app()
    print("app:", app, "project_id:", getattr(app, "project_id", None))
    client = firestore_client()
    print("client:", client)
    docs = list(client.collection("familyInvitations").limit(5).get())
    print("familyInvitations sample count:", len(docs))
    for doc in docs:
        data = doc.to_dict() or {}
        print("  id:", doc.id, "ownerUid:", data.get("ownerUid"), "status:", data.get("status"))
except Exception as error:
    print("FAILED:", type(error).__name__, error)
    traceback.print_exc()
