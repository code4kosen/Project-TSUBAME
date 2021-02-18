import logging

from google.appengine.ext.webapp.mail_handlers import InboundMailHandler
import webapp2

class ReceiveMailHandler(InboundMailHandler):
    def receive(self, mail_message):
        cred = credentials.initialize_app(cred,{
            'projectId': 'project-tsubame',
            })
        db = firestore.client()
        body_text = mail_message.bodies('text/plain')

        for content_type, body in body_text:
            logging.info(body.decode())
            data = {
                    u'Body': body.decode(),
                    u'Date': mail_message.date,
                    u'Name': "館山市安全・安心メール"
                    u'Label': "その他"
                    }

            db.collection('u'news').add(data)

app = webapp2.WSGIApplication([ReceiveMailHandler.mapping()], debug=True)
