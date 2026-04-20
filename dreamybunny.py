
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

@dreamybunnyApp.route('/sUsuario',methods = ['GET','POST'])
def sUsuario():
    selUsuario = db.connection.cursor()
    selUsuario.execute("SELECT * FROM usuario")
    u = selUsuario.fetchall()
    selUsuario.close()
    return render_template('users.html', usuarios=u)

@dreamybunnyApp.route('/iUsuario',methods = ['GET','POST'])
def iUsuario():
    if request.method == 'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        perfil = request.form['perfil']
        claveCifrada = generate_password_hash(clave)
        regUsuario = db.connection.cursor()
        regUsuario.execute("INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)", (nombre.upper(), correo, claveCifrada, perfil))
        db.connection.commit()
        flash('Usuario registrado correctamente')
        regUsuario.close()
        return redirect(url_for('sUsuario'))
    else:
        return render_template('users.html')

@dreamybunnyApp.route('/uUsuario/<int:id>',methods = ['GET','POST'])
def uUsuario(id):
    if request.method == 'POST':
        id = request.form['id']
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form['clave']
        perfil = request.form['perfil']
        claveCifrada = generate_password_hash(clave)
        actUsuario = db.connection.cursor()
        actUsuario.execute("UPDATE usuario SET nombre=%s, correo=%s, clave=%s, perfil=%s WHERE id=%s", (nombre.upper(), correo, claveCifrada, perfil, id))
        db.connection.commit()
        flash('Usuario actualizado correctamente')
        actUsuario.close()
        return redirect(url_for('sUsuario'))
    else:
        return render_template('users.html')
   
@dreamybunnyApp.route('/dUsuario/<int:id>',methods = ['GET','POST'])
def dUsuario(id):
    if request.method == 'POST':
        delUsuario = db.connection.cursor()
        delUsuario.execute("DELETE FROM usuario WHERE id=%s", (id,))
        db.connection.commit()
        delUsuario.close()
        flash('usuario eliminado')
        return redirect(url_for('sUsuario'))
    else:
        return render_template('users.html')


@dreamybunnyApp.route('/sProducto',methods= ['GET','POST'])
@login_required
def sProducto():
    selProducto = db.connection.cursor()
    selProducto.execute ("SELECT * FROM usuario" )
    p= selProducto.close()
    return render_template('productos.html',productos=p)
    
    
if __name__ == '__main__':
    dreamybunnyApp.run(port=3000, debug=True)


