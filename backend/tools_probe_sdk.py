import google.cloud.firestore as gcf
from google.cloud.firestore_v1 import client as v1_client

print("google-cloud-firestore version:", getattr(gcf, "__version__", "?"))
print("Client.collection signature/docstring:")
print(v1_client.Client.collection.__doc__)

from app.firebase_gateway import firestore_client

db = firestore_client()
print("db type:", type(db))
col = db.collection("familyInvitations")
print("col type:", type(col))
print("col has .doc     :", hasattr(col, "doc"))
print("col has .document :", hasattr(col, "document"))
print("col mro:", [c.__name__ for c in type(col).__mro__])
