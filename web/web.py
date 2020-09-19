from flask import render_template, request


def index_fnc():
    name = request.args.get("name", default="NONE", type=str)
    return render_template("index.html", name=name)
