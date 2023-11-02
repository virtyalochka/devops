from flask_login import current_user

class UsersPolicy:
    def __init__(self, record):
        self.record = record

    def update(self):
        return current_user.is_moder() or current_user.is_admin()

    def create(self):
        return current_user.is_admin()

    def delete(self):
        return current_user.is_admin()

    def show(self):
        return current_user.is_user()
