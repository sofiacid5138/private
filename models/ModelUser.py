from .entities.User import User
from werkzeug.security import check_password_hash

class ModelUser():

    @classmethod
    def signin(cls, db, user):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT id, perfil, nombre, correo, clave FROM usuario WHERE correo = %s"
            cursor.execute(sql, (user.correo,))
            row = cursor.fetchone()
            if row and check_password_hash(row[4], user.clave):
                logged_user = User(id=row[0], perfil=row[1], nombre=row[2], correo=row[3], clave=None)
                return logged_user
            return None
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def signup(cls, db, user):
        try:
            cursor = db.connection.cursor()
            sql_check = "SELECT correo FROM usuario WHERE correo = %s"
            cursor.execute(sql_check, (user.correo,))
            if cursor.fetchone():
                return False
            
            sql_insert = "INSERT INTO usuario (perfil, nombre, correo, clave) VALUES (%s, %s, %s, %s)"
            cursor.execute(sql_insert, (user.perfil, user.nombre.upper(), user.correo, user.clave))
            db.connection.commit()
            return True
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)

    @classmethod
    def get_by_id(cls, db, id):
        try:
            cursor = db.connection.cursor()
            sql = "SELECT id, perfil, nombre, correo FROM usuario WHERE id = %s"
            cursor.execute(sql, (id,))
            row = cursor.fetchone()
            if row:
                return User(id=row[0], perfil=row[1], nombre=row[2], correo=row[3], clave=None)
            return None
        except Exception as ex:
            raise Exception(ex)
