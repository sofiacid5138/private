# models/entities/User.py
from flask_login import UserMixin

class User(UserMixin):

    def __init__(self, id, perfil, nombre, correo, clave):
        self.id = id
        self.perfil = perfil
        self.nombre = nombre
        self.correo = correo
        self.clave = clave