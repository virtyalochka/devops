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

    def test_view_collection(self):
        # Авторизуем пользователя
        with self.app as c:
            c.post('/auth/login', data=dict(
                login='cool',
                password='hacker',
                remember_me=False
            ))
            response = c.get(f'/books/?page=1')
            self.assertIn(b'Logout', response.data)

if __name__ == '__main__':
    unittest.main()