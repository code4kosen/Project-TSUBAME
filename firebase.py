import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use a service account
cred = credentials.Certificate('./project-tsubame-fb02b32d8ac5.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection(u'news')
docs = users_ref.stream()

for doc in docs:
    print(format(doc.to_dict()))
