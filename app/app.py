from flask import Flask, render_template, send_from_directory
from mysql_db import MySQL

app = Flask(__name__)
app.config.from_pyfile('config.py')

db = MySQL(app)

from auth import bp as auth_bp, init_login_manager
from books import bp as books_bp
from collect import bp as collections_bp

app.register_blueprint(auth_bp)
app.register_blueprint(books_bp)
app.register_blueprint(collections_bp)
init_login_manager(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/media/<path:filename>')
def media(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename, mimetype='image/jpeg')