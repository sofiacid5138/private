import sys
import os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from flask import Flask, render_template, url_for, request, flash, redirect
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required
from werkzeug.security import generate_password_hash

from config import config
from models.ModelUser import ModelUser
from models.entities.User import User

dreamybunnyApp = Flask(__name__)

# Configuración de la base de datos
dreamybunnyApp.config.from_object(config['development'])
db = MySQL(dreamybunnyApp)

# Configuración del LoginManager
adminUsuarios = LoginManager(dreamybunnyApp)
adminUsuarios.login_view = 'signin' # A dónde redirigir si no ha iniciado sesión

@adminUsuarios.user_loader
def cargarUsuario(id):
    """Carga el usuario desde la base de datos usando su ID."""
    return ModelUser.get_by_id(db, int(id))

# --- RUTAS DE LA APLICACIÓN ---

@dreamybunnyApp.route('/')
def home():
    """Página de inicio."""
    return render_template('home.html')

@dreamybunnyApp.route('/signup', methods=['GET', 'POST'])
def signup():
    """Página de registro de nuevos usuarios."""
    if request.method == 'POST':
        # Validación básica para que no haya campos vacíos
        if not request.form['nombre'] or not request.form['correo'] or not request.form['clave']:
            flash("Por favor, completa todos los campos.", "warning")
            return redirect(url_for('signup'))
            
        clave_cifrada = generate_password_hash(request.form['clave'])
        # Creamos el objeto usuario
        nuevo_usuario = User(
            id=None,
            perfil='U', # Perfil de usuario por defecto
            nombre=request.form['nombre'],
            correo=request.form['correo'],
            clave=clave_cifrada
        )
        
        # Intentamos registrar al usuario
        registrado = ModelUser.signup(db, nuevo_usuario)
        
        if registrado:
            flash("¡Registro exitoso! Ahora puedes iniciar sesión.", "success")
            return redirect(url_for('signin'))
        else:
            flash("El correo ya está en uso. Intenta con otro.", "danger")
            return redirect(url_for('signup'))
    else:
        return render_template('signup.html')

@dreamybunnyApp.route('/signin', methods=['GET', 'POST'])
def signin():
    """Página de inicio de sesión."""
    if request.method == 'POST':
        usuario = User(id=None, perfil=None, nombre=None, correo=request.form['correo'], clave=request.form['clave'])
        usuario_autenticado = ModelUser.signin(db, usuario)

        if usuario_autenticado:
            login_user(usuario_autenticado) # Aquí Flask-Login hace su magia
            flash(f"¡Bienvenido de nuevo, {usuario_autenticado.nombre}!", "info")
            if usuario_autenticado.perfil == 'A':
                return redirect(url_for('admin_page'))
            else:
                return redirect(url_for('user_page'))
        else:
            flash("Correo o contraseña incorrectos. Inténtalo de nuevo.", "danger")
            return redirect(url_for('signin'))
    else:
        return render_template('signin.html') # Asumiendo que tienes un signin.html

@dreamybunnyApp.route('/logout')
@login_required
def logout():
    """Cierra la sesión del usuario."""
    logout_user()
    flash("Has cerrado sesión.", "info")
    return redirect(url_for('home'))

@dreamybunnyApp.route('/admin')
@login_required
def admin_page():
    """Página para administradores."""
    return render_template('admin.html')

@dreamybunnyApp.route('/usuario')
@login_required
def user_page():
    """Página para usuarios normales."""
    return render_template('user.html') # Asumiendo que tienes un user.html

if __name__ == '__main__':
    dreamybunnyApp.run(port=3000, debug=True)