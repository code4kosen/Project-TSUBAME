from google.cloud import firestore
from PIL import Image, ImageDraw, ImageFont
from time import sleep
from IT8951 import constants
from IT8951.display import AutoEPDDisplay
from IT8951.display import VirtualEPDDisplay

import sys

def clear_display(display):
    print('Clearing display...')
    display.clear()

def display_image_8bpp(display,img_path):
    #img_path = 'images/sleeping_penguin.png'
    print('Displaying "{}"...'.format(img_path))

    # clearing image to white
    display.frame_buf.paste(0xFF, box=(0, 0, display.width, display.height))

    img = Image.open(img_path)

    # TODO: this should be built-in
    dims = (display.width, display.height)

    img.thumbnail(dims)
    paste_coords = [dims[i] - img.size[i] for i in (0,1)]  # align image with bottom of display
    display.frame_buf.paste(img, paste_coords)

    display.draw_full(constants.DisplayModes.GC16)

#arg=sys.argv

def complete():
    titlesize=200
    mainzize=100
    db = firestore.Client.from_service_account_json('./project-tsubame-fb02b32d8ac5.json')
    cities_ref = db.collection(u'news')
    query = cities_ref.order_by(u'Date', direction=firestore.Query.DESCENDING).limit(1)
    docs = query.stream()

    for doc in docs:
        print(format(doc.to_dict()["Name"]))
        print(format(doc.to_dict()["Body"]))
        print(format(doc.to_dict()["Date"]))
        name=format(doc.to_dict()["Name"])
        text=format(doc.to_dict()["Body"]).replace("\\n","\n")

    im = Image.new("RGB",(2100,1600),"white")# Imageインスタンスを作る
    draw = ImageDraw.Draw(im)# im上のImageDrawインスタンスを作る
    fnt1 = ImageFont.truetype('./NotoSansCJKjp-Regular.otf',size=titlesize) #ImageFontインスタンスを作る
    fnt2 = ImageFont.truetype('./NotoSansCJKjp-Regular.otf',size=mainzize)
    draw.text((0,0),name,"orange",font=fnt1) #fontを指定
    draw.text((0,titlesize+100),text,"black",font=fnt2)
    im.save("./test.jpg",quality=200)


    display = AutoEPDDisplay(vcom=-2.06, rotate=None, spi_hz=24000000)
    print('VCOM set to', display.epd.get_vcom())

    clear_display(display)
    #display_gradient(display)
    #partial_update(display)
    display_image_8bpp(display,"/home/pi/python/test.jpg")

    print('Done!')

def main():
    morning=schedule.every().day.at("00:10").do(complete)
    noon=schedule.every().day.at("00:11").do(complete)
    afternoon=schedule.every().day.at("12:00").do(complete)

    while True:
        time.sleep(60)
        morning.run_pending()
        noon.run_pending()
        afternoon.run_pending()