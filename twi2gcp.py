# -*- coding: utf-8 -*-

from flask import Flask, request, render_template
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
import datetime
import logging

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__, static_url_path='', static_folder='./build/web')

@app.route("/",methods=["GET"])
def index():
    return app.send_static_file("index.html")

@app.route("/twi", methods=["POST"])
def recive():
    #データの取得/
    kari=request.get_json(force=True)
    body = kari['Body']
    date=datetime.datetime.now()
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
        u'Date': date,
        u'Name': fromNum
    }
    db.collection(u'news').add(data)


    logging.info(
        'received Body=%s\n, Date=%s\n Name=%s',
        body,date,fromNum
        )

    return request.get_data()


if __name__ == "__main__":
    app.run(debug=True)
