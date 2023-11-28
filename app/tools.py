import hashlib
import os
from werkzeug.utils import secure_filename
from app import db, app

class ImageSaver:
    def __init__(self, file):
        self.stream = file
        self.md5_hash = None

    def calculate_md5(self):
        self.md5_hash = hashlib.md5(self.stream.read()).hexdigest()
        self.stream.seek(0)
        return self.md5_hash

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img[0]
        filename = secure_filename(self.stream.filename)

        if self.md5_hash is None:
            self.calculate_md5()

        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

        with db.connection().cursor() as cursor:
            cursor.execute("INSERT INTO covers (filename, mime_type, md5_hash) VALUES (%s, %s, %s)",
                        (filename, self.stream.mimetype, self.md5_hash))
            cover_id = cursor.lastrowid
            db.connection().commit()

        self.stream.save(file_path)
        return cover_id

    def __find_by_md5_hash(self):
        if self.md5_hash is None:
            self.calculate_md5()
            
        with db.connection().cursor() as cursor:
            cursor.execute("SELECT id FROM covers WHERE md5_hash = %s", (self.md5_hash,))
            return cursor.fetchone()