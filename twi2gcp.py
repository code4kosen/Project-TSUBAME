from flask import Flask, request
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
import datetime

app = Flask(__name__)

@app.route("/twi", methods=["POST"])
def recive():
    # データの取得
    kari=request.get_json(force=True)
    body = kari['Body']
    fromNum = kari['From']

    # GCF初期化
    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred, {
        'projectId': 'project-tsubame',
    })
    db = firestore.client()

    # GCFにデータを追加
    data = {
        u'Body': body,
        u'Date': datetime.datetime.now(),
        u'Name': fromNum
    }
    db.collection(u'news').add(data)
    return request.get_data()


if __name__ == "__main__":
    app.run(debug=True)