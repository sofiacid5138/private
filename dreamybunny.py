from flask import Flask, render_template, url_for, request, flash, redirect, session
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from config import config
from models.ModelUser import ModelUser
from models.entities.User import User
from flask_mail import Mail, Message
import os

dreamybunnyApp = Flask(__name__)

# =========================================================
# CONFIG
# =========================================================
dreamybunnyApp.config.from_object(config['development'])
dreamybunnyApp.config.from_object(config['mail'])

mail = Mail(dreamybunnyApp)
db = MySQL(dreamybunnyApp)

adminUsuarios = LoginManager(dreamybunnyApp)
adminUsuarios.login_view = 'signin'

@adminUsuarios.user_loader
def cargarUsuario(id):
    return ModelUser.get_by_id(db, int(id))

# =========================================================
# 🏠 RUTAS
# =========================================================

@dreamybunnyApp.route('/')
def home():
    return render_template('home.html')

@dreamybunnyApp.route('/menu')
def menu():
    return render_template('menu.html')

@dreamybunnyApp.route('/bunnys')
def bunnys():
    return render_template('bunnys.html')

# =========================================================
# 🛒 CARRITO
# =========================================================

@dreamybunnyApp.route('/carrito')
def carrito():

    carrito = session.get('carrito', [])

    total = 0
    for item in carrito:
        total += float(item['precio'])

    return render_template('carrito.html', carrito=carrito, total=total)


@dreamybunnyApp.route('/iCarrito/<int:id>')
def iCarrito(id):

    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM menu_bunny WHERE id=%s", (id,))
    p = cursor.fetchone()
    cursor.close()

    if p:

        producto = {
            'id': p[0],
            'nombre': p[1],
            'categoria': p[2],
            'precio': float(p[3]),
            'imagen': p[4]
        }

        if 'carrito' not in session:
            session['carrito'] = []

        session['carrito'].append(producto)

        flash('Producto agregado al carrito 💖')

    return redirect(url_for('menu'))

# =========================================================
# 👤 SIGNUP
# =========================================================

@dreamybunnyApp.route('/signup', methods=['GET', 'POST'])
def signup():

    if request.method == 'POST':

        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']

        if not nombre or not correo or not clave:
            flash("Completa todos los campos", "warning")
            return redirect(url_for('signup'))

        clave_cifrada = generate_password_hash(clave)

        cursor = db.connection.cursor()
        cursor.execute("""
            INSERT INTO usuario (nombre, correo, clave, perfil)
            VALUES (%s, %s, %s, 'U')
        """, (nombre.upper(), correo, clave_cifrada))

        db.connection.commit()
        cursor.close()

        flash("Registro exitoso 🎉 ahora inicia sesión", "success")
        return redirect(url_for('signin'))

    return render_template('signup.html')

# =========================================================
# 🔐 SIGNIN
# =========================================================

@dreamybunnyApp.route('/signin', methods=['GET', 'POST'])
def signin():

    if request.method == 'POST':

        correo = request.form['correo']
        clave = request.form['clave']

        cursor = db.connection.cursor()
        cursor.execute("""
            SELECT id, nombre, correo, clave, perfil
            FROM usuario
            WHERE correo=%s
        """, (correo,))
        user = cursor.fetchone()
        cursor.close()

        if user and check_password_hash(user[3], clave):

            usuario = User(
                id=user[0],
                nombre=user[1],
                correo=user[2],
                clave=user[3],
                perfil=user[4]
            )

            login_user(usuario)

            flash(f"¡Bienvenido {usuario.nombre}! 💖", "login_success")

            return redirect(url_for('home'))

        flash("Correo o contraseña incorrectos", "danger")
        return redirect(url_for('signin'))

    return render_template('signin.html')

# =========================================================
# 🚪 LOGOUT
# =========================================================

@dreamybunnyApp.route('/logout')
@login_required
def logout():

    logout_user()
    flash("Has cerrado sesión")

    return redirect(url_for('home'))

# =========================================================
# 👥 USUARIOS
# =========================================================

@dreamybunnyApp.route('/sUsuario')
def sUsuario():

    cursor = db.connection.cursor()

    cursor.execute("""
        SELECT id, nombre, correo, perfil
        FROM usuario
    """)

    usuarios = cursor.fetchall()

    cursor.close()

    return render_template('users.html', usuarios=usuarios)

# =========================================================
# 👑 ADMIN PROTEGIDO (ÚNICO, CORRECTO)
# =========================================================

@dreamybunnyApp.route('/admin')
@login_required
def admin_page():

    if current_user.perfil != 'A':
        flash("No tienes permisos de administrador 💔")
        return redirect(url_for('home'))

    return render_template('admin.html')

# =========================================================
# 🚀 RUN
# =========================================================

if __name__ == '__main__':
    dreamybunnyApp.run(port=3000, debug=True)