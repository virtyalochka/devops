import mysql.connector
from flask import g

class MySQL:
    def __init__(self, app):
        self.app = app
        self.app.teardown_appcontext(self.close_connection)

    def config(self):
        return {
            "user": self.app.config['MYSQL_USER'],
            "password": self.app.config['MYSQL_PASSWORD'],
            "host": self.app.config['MYSQL_HOST'],
            "database": self.app.config['MYSQL_DATABASE']
        }

    def close_connection(self, e=None):
        mysql = g.pop('mysql', None)

        if mysql is not None:
            mysql.close()

    def connection(self):
        if 'mysql' not in g:
            g.mysql = mysql.connector.connect(**self.config())
        return g.mysql
