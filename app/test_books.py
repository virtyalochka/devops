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
        with self.app:
            response = self.app.get('/books/show/1')
            self.assertIn(b'2023-10-27 13:30:13', response.data)
            response = self.app.get('/books/show/1337')
            self.assertIn(b'500 Internal Server Error', response.data)
            response = self.app.get('/books/?page=1')
            self.assertIn(b'2.50', response.data)
if __name__ == '__main__':
    unittest.main()