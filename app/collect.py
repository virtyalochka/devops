from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login import login_required, current_user
from auth import permission_check
import mysql.connector
from app import db

bp = Blueprint('collect', __name__, url_prefix='/collect')

@bp.route('/my_collections')
@login_required
def my_collections():
    if current_user.is_authenticated:
        collections = get_user_collections(current_user.id)
        return render_template('collect/my_collections.html', collections=collections)
    else:
        flash('Доступ запрещен', 'danger')
        return redirect(url_for('index'))

@bp.route('/view_collection/<int:collection_id>')
@login_required
def view_collection(collection_id):
    collection = get_collection_by_id(collection_id)
    if collection and collection.user_id == current_user.id:
        books = get_books_in_collection(collection_id)
        return render_template('collect/view_collection.html', collection=collection, books=books)
    else:
        flash('Доступ запрещен', 'danger')
        return redirect(url_for('collect.my_collections'))

def get_user_collections(user_id):
    cursor = db.connection().cursor(named_tuple=True)
    cursor.execute('SELECT collections.*, COUNT(books_collections.book_id) AS book_count FROM collections LEFT JOIN books_collections ON collections.id = books_collections.collection_id WHERE collections.user_id = %s GROUP BY collections.id', (user_id,))
    collections = cursor.fetchall()
    cursor.close()
    return collections

def get_collection_by_id(collection_id):
    cursor = db.connection().cursor(named_tuple=True)
    cursor.execute('SELECT * FROM collections WHERE id = %s', (collection_id,))
    collection = cursor.fetchone()
    cursor.close()
    return collection

def get_books_in_collection(collection_id):
    cursor = db.connection().cursor(named_tuple=True)
    cursor.execute('SELECT books.* FROM books JOIN books_collections ON books.id = books_collections.book_id WHERE books_collections.collection_id = %s', (collection_id,))
    books = cursor.fetchall()
    cursor.close()
    return books