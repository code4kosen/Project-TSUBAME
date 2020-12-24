import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials

app = Flask(__name__)

def main():
    print "Enter the number. > ";
    number=input()
    print "Enter number's name. > ";
    name=input()

    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred, {
        'projectId': 'project-tsubame',
    })
    db = firestore.client()

    data = {
        u'Number': number,
        u'Name': name
    }
    db.collection(u'username').add(data)
