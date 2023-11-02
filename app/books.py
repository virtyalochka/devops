from flask import Blueprint, render_template, request, redirect, url_for, flash, current_app
from flask_login import login_required, current_user
from app import db
from werkzeug.utils import secure_filename
from tools import ImageSaver
from auth import permission_check
import mysql.connector
import math
import os
from bleach import clean
import markdown

PER_PAGE = 3
bp = Blueprint('books', __name__, url_prefix='/books')

@bp.route('/show/<int:book_id>')
def show(book_id):
    cursor = db.connection().cursor(named_tuple=True)

    cursor.execute('SELECT * FROM books WHERE id = %s', (book_id,))
    book = cursor.fetchone()
    book_description = book.description
    book_description_html = markdown.markdown(book_description)

    # Запрос для получения информации о книге
    cursor.execute('SELECT books.*, covers.filename AS cover_filename FROM books JOIN covers ON books.cover_id = covers.id WHERE books.id = %s', (book_id,))
    book = cursor.fetchone()

    cursor.execute('SELECT genres.name FROM genres JOIN books_genres ON genres.id = books_genres.genre_id WHERE books_genres.book_id = %s', (book_id,))
    genres = [genre[0] for genre in cursor.fetchall()]

    # Запрос для получения отзывов
    cursor.execute('SELECT reviews.*, users.first_name, users.last_name FROM reviews JOIN users ON reviews.user_id = users.id WHERE reviews.book_id = %s', (book_id,))
    reviews = cursor.fetchall()

    # Проверка на наличие отзыва пользователя
    has_reviewed = False
    current_user_review = None
    if current_user.is_authenticated:
        for review in reviews:
            if review.user_id == current_user.id:
                has_reviewed = True
                current_user_review = review
                break
    cursor.close()
    return render_template('books/show.html', book=book, genres=genres, reviews=reviews, has_reviewed=has_reviewed, current_user_review=current_user_review, book_description_html=book_description_html)

@bp.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    limit = PER_PAGE
    offset = (page - 1) * limit

    query = ('SELECT b.*, c.filename AS cover_filename, COUNT(r.id) AS review_count, AVG(r.rating) AS avg_rating, '
             'GROUP_CONCAT(DISTINCT g.name) AS genres '
             'FROM books AS b '
             'LEFT JOIN reviews AS r ON b.id = r.book_id '
             'LEFT JOIN books_genres AS bg ON b.id = bg.book_id '
             'LEFT JOIN genres AS g ON bg.genre_id = g.id '
             'LEFT JOIN covers AS c ON b.cover_id = c.id '
             'GROUP BY b.id '
             'ORDER BY b.year DESC '  # Сортировка по убыванию года
             'LIMIT %s OFFSET %s')

    connection = db.connection()
    cursor = connection.cursor(named_tuple=True)

    try:
        cursor.execute(query, (limit, offset))
        books = cursor.fetchall()

        query = 'SELECT COUNT(*) AS total_count FROM books'
        cursor.execute(query)
        total_books = cursor.fetchone().total_count

        total_pages = math.ceil(total_books / limit)
    finally:
        cursor.close()

    return render_template('books/index.html', books=books, last_page=total_pages, current_page=page, reviews_count=reviews_count)

@bp.route('/<int:book_id>/give_review')
@login_required
def give_review(book_id):
    cursor = db.connection().cursor(named_tuple=True)
    cursor.execute('SELECT * FROM books WHERE id = %s', (book_id,))
    book = cursor.fetchone()
    cursor.close()
    return render_template('books/give_review.html', book=book)

@bp.route('/<int:book_id>/send', methods=['POST'])
@login_required
def send_review(book_id):
    try:
        text = clean(request.form.get('text_review'))
        rating = int(request.form.get('rating_id'))

        connection = db.connection()
        cursor = connection.cursor()

        # Проверяем, существует ли уже отзыв от текущего пользователя
        cursor.execute('SELECT * FROM reviews WHERE book_id = %s AND user_id = %s', (book_id, current_user.id))
        existing_review = cursor.fetchone()

        if existing_review:
            # Отзыв уже существует, обновляем его значения
            update_query = 'UPDATE reviews SET text = %s, rating = %s WHERE id = %s'
            cursor.execute(update_query, (text, rating, existing_review['id']))
        else:
            # Отзыв не существует, добавляем новый отзыв
            insert_query = 'INSERT INTO reviews (text, rating, book_id, user_id) VALUES (%s, %s, %s, %s)'
            cursor.execute(insert_query, (text, rating, book_id, current_user.id))

        connection.commit()
        flash('Ваш отзыв был успешно отправлен', 'success')
    except mysql.connector.Error as error:
        flash(f'При отправке отзыва произошла ошибка: {error}', 'danger')
        connection.rollback()
        return redirect(url_for('books.show', book_id=book_id))
    finally:
        cursor.close()
        connection.close()

    return redirect(url_for('books.show', book_id=book_id))

@bp.route('/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
@permission_check('update')
def edit(book_id):
    connection = db.connection()
    cursor = connection.cursor(named_tuple=True)

    if request.method == 'POST':
        title = request.form['title']
        author = request.form['author']
        description = clean(request.form['description'], tags=[], strip=True)
        genres = request.form.getlist('genre[]')
        year = request.form['year']
        publisher = request.form['publisher']
        volume = request.form['volume']

        try:
            # Обновление книги
            cursor.execute("UPDATE books SET title = %s, author = %s, description = %s, volume = %s, year = %s, publisher = %s WHERE id = %s",
                           (title, author, description, volume, year, publisher, book_id))

            # Обновление жанров
            cursor.execute("DELETE FROM books_genres WHERE book_id = %s", (book_id,))
            for genre_id in genres:
                cursor.execute("INSERT INTO books_genres (book_id, genre_id) VALUES (%s, %s)",
                               (book_id, genre_id))
            connection.commit()
            return redirect(url_for('books.show', book_id=book_id))
        except:
            connection.rollback()
            return "При сохранении данных возникла ошибка. Проверьте корректность введённых данных."

    cursor.execute("SELECT id, name FROM genres")
    genres = cursor.fetchall()

    cursor.execute("SELECT * FROM books WHERE id = %s", (book_id,))
    book = cursor.fetchone()

    if not book:
        return redirect(url_for('books.index'))

    cursor.execute("SELECT genre_id FROM books_genres WHERE book_id = %s", (book_id,))
    book_genres = [row[0] for row in cursor.fetchall()]

    flash('Книга успешно изменена!', 'success')
    return render_template('books/edit.html', genres=genres, book=book, book_genres=book_genres)

@bp.route('/create', methods=['GET', 'POST'])
@login_required
@permission_check('create')
def create():
    connection = db.connection()
    cursor = connection.cursor(named_tuple=True)

    if request.method == 'POST':
        title = request.form['title']
        author = request.form['author']
        description = clean(request.form['description'], tags=[], strip=True)
        genres = request.form.getlist('genre[]')
        cover = request.files['cover']
        year = request.form['year']
        publisher = request.form['publisher']
        volume = request.form['volume']

        filename = secure_filename(cover.filename)
        image_saver = ImageSaver(cover)
        cover_id = image_saver.save()
        connection.commit()

        try:
            md5_hash = image_saver.calculate_md5()
            cursor.execute("SELECT id FROM covers WHERE md5_hash = %s", (md5_hash,))
            existing_cover = cursor.fetchone()

            if existing_cover:
                cover_id = existing_cover[0]
            else:
                cursor.execute("INSERT INTO covers (filename, mime_type, md5_hash) VALUES (%s, %s, %s)",
                               (filename, cover.mimetype, md5_hash))
                connection.commit()
                cover_id = cursor.lastrowid

            # Сохранение книги
            cursor.execute("INSERT INTO books (title, author, description, year, publisher, cover_id, volume) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                            (title, author, description, year, publisher, cover_id, volume))
            connection.commit()
            book_id = cursor.lastrowid

            for genre_id in genres:
                cursor.execute("INSERT INTO books_genres (book_id, genre_id) VALUES (%s, %s)", (book_id, genre_id))
            connection.commit()

            cursor.execute("SELECT * FROM books WHERE id = %s", (book_id,))
            book = cursor.fetchone()
            if not book:
                connection.rollback()
                flash('При сохранении данных возникла ошибка. Проверьте корректность введённых данных.', 'danger')
                return render_template('books/create.html', genres=genres, book=request.form)

            cursor.execute("SELECT genre_id FROM books_genres WHERE book_id = %s", (book_id,))
            book_genres = [row[0] for row in cursor.fetchall()]
            connection.commit()
            flash('Книга успешно добавлена!', 'success')
            return redirect(url_for('books.show', book_id=book_id, book_genres=book_genres))
        except mysql.connector.Error as error:
            connection.rollback()
            flash(f'При сохранении данных возникла ошибка: {error}', 'danger')
            return render_template('books/create.html', genres=genres, book=request.form)

    cursor.execute("SELECT id, name FROM genres")
    genres = cursor.fetchall()

    return render_template('books/create.html', genres=genres, book=request.form)

@bp.route('/delete/<int:book_id>', methods=['POST'])
@login_required
@permission_check('delete')
def delete_book(book_id):
    cursor = db.connection().cursor()

    cursor.execute('SELECT * FROM books WHERE id = %s', (book_id,))
    book = cursor.fetchone()
    if not book:
        flash('Книга не найдена', 'error')
        return redirect(url_for('books.index'))
    try:
        # Удаление обложки из файловой системы
        if book[5]:
            cover_path = os.path.join(current_app.config['UPLOAD_FOLDER'], book[5])
            if os.path.exists(cover_path):
                os.remove(cover_path)

        cursor.execute('DELETE FROM books WHERE id = %s', (book_id,))
        db.connection().commit()
        flash('Книга успешно удалена', 'success')
    except mysql.connector.Error as error:
        flash(f'При удалении книги произошла ошибка: {error}', 'danger')
        db.connection().rollback()
    finally:
        cursor.close()

    return redirect(url_for('books.index'))

def reviews_count(book_id):
    cursor = db.connection().cursor()
    cursor.execute("SELECT COUNT(*) FROM reviews WHERE book_id = %s", (book_id,))
    count = cursor.fetchone()[0]
    cursor.close()
    return count