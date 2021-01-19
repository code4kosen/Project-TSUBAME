from google.cloud import firestore

# Explicitly use service account credentials by specifying the private key
# file.
db = firestore.Client.from_service_account_json('/mnt/c/Users/hmjn0/myfile/project-tsubame-4501f3895aca.json')

#users_ref = db.collection(u'news')
#docs = users_ref.order_by("Date").stream()

cities_ref = db.collection(u'news')
query = cities_ref.order_by(u'Date', direction=firestore.Query.DESCENDING)
docs = query.stream()

for doc in docs:
    print(format(doc.to_dict()["Body"]))
    print(format(doc.to_dict()["Date"]))
