import unittest
from app import app
from mysql_db import MySQL

class BookTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

        # Подключаемся к MySQL и создаем соединение
        self.mysql = MySQL(app)
        self.connection = self.mysql.connect()
        self.cursor = self.connection.cursor()

    def tearDown(self):
        # Закрываем соединение с MySQL после тестов
        self.cursor.close()
        self.connection.close()

    def test_show_book(self):
        with self.app.test_request_context('/books/show/1'):
            response = self.app.get('/books/show/1')
            self.assertIn(b'Book Title', response.data)

if __name__ == '__main__':
    unittest.main()
