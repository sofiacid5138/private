from flask import Flask, render_template, url_for, request, flash, redirect
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required
from werkzeug.security import generate_password_hash
from config import config
from models.ModelUser import ModelUser
from models.entities.User import User

from flask_mail import Mail, Message

dreamybunnyApp = Flask(__name__)

# ✅ CONFIGURACIÓN PRIMERO
dreamybunnyApp.config.from_object(config['development'])
dreamybunnyApp.config.from_object(config['mail'])

# ✅ LUEGO MAIL
mail = Mail(dreamybunnyApp)

# Configuración de la base de datos
db = MySQL(dreamybunnyApp)

# Configuración del LoginManager
adminUsuarios = LoginManager(dreamybunnyApp)
adminUsuarios.login_view = 'signin'

@adminUsuarios.user_loader
def cargarUsuario(id):
    return ModelUser.get_by_id(db, int(id))


# --- RUTAS DE LA APLICACIÓN ---

@dreamybunnyApp.route('/')
def home():
    return render_template('home.html')

@dreamybunnyApp.route('/menu')
def menu():
    return render_template('menu.html')

@dreamybunnyApp.route('/bunnys')
def bunnys():
    return render_template('bunnys.html')



@dreamybunnyApp.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':

        if not request.form['nombre'] or not request.form['correo'] or not request.form['clave']:
            flash("Por favor, completa todos los campos.", "warning")
            return redirect(url_for('signup'))
            
        clave_cifrada = generate_password_hash(request.form['clave'])

        nuevo_usuario = User(
            id=None,
            perfil='U',
            nombre=request.form['nombre'],
            correo=request.form['correo'],
            clave=clave_cifrada
        )

        # ✅ GUARDAR USUARIO
        regUsuario = db.connection.cursor()
        regUsuario.execute(
            "INSERT INTO usuario (nombre, correo, clave, perfil) VALUES (%s, %s, %s, %s)",
            (nuevo_usuario.nombre.upper(), nuevo_usuario.correo, nuevo_usuario.clave, nuevo_usuario.perfil)
        )
        db.connection.commit()
        regUsuario.close()

        # ✅ CREAR CORREO
        msg = Message(
            subject='Bienvenido a Dreamy Bunny 💖',
            sender=dreamybunnyApp.config['MAIL_USERNAME'],
            recipients=[request.form['correo']]
        )

        msg.html = render_template('mail.html', usuario=nuevo_usuario)

        # ✅ ENVIAR CORREO (CON SEGURIDAD)
        try:
            mail.send(msg)
            flash("Te enviamos un correo de bienvenida 💌", "success")
        except Exception as e:
            print("ERROR MAIL:", e)
            flash("Usuario creado pero no se pudo enviar el correo ", "warning")

        flash("Registro exitoso 🎉", "success")
        return redirect(url_for('signin'))

    return render_template('signup.html')


@dreamybunnyApp.route('/signin', methods=['GET', 'POST'])
def signin():
    if request.method == 'POST':
        usuario = User(id=None, perfil=None, nombre=None, correo=request.form['correo'], clave=request.form['clave'])
        usuario_autenticado = ModelUser.signin(db, usuario)

        if usuario_autenticado:
            login_user(usuario_autenticado)
            flash(f"¡Bienvenido de nuevo, {usuario_autenticado.nombre}!", "info")
            if usuario_autenticado.perfil == 'A':
                return redirect(url_for('admin_page'))
            else:
                return redirect(url_for('user_page'))
        else:
            flash("Correo o contraseña incorrectos. Inténtalo de nuevo.", "danger")
            return redirect(url_for('signin'))
    else:
        return render_template('signin.html')


@dreamybunnyApp.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Has cerrado sesión.", "info")
    return redirect(url_for('home'))

@dreamybunnyApp.route('/admin')
@login_required
def admin_page():
    return render_template('admin.html')

@dreamybunnyApp.route('/usuario')
@login_required
def user_page():
    return render_template('user.html')

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
    selProducto.execute("SELECT * FROM usuario")
    p = selProducto.close()
    return render_template('productos.html',productos=p)

@dreamybunnyApp.route('/iProducto',methods= ['GET','POST'])
def iProducto():
    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        precio = request.form['precio']
        imagen = request.form['imagen']
        if imagen and imagen.filename :
            nombre_imagen = imagen.filename
            imagen.save(os.path.join('static/images', nombre_imagen))
            NuevoProducto = db.connection.cursor()
        NuevoProducto.execute("INSERT INTO producto (nombre, descripcion, precio, imagen) VALUES (%s, %s, %s, %s)", (nombre.upper(), descripcion, precio, imagen))
        db.connection.commit()
        flash('Producto registrado correctamente')
        NuevoProducto.close()
        return redirect(url_for('sProducto'))
    else:
        return render_template('productos.html')
if __name__ == '__main__':
    dreamybunnyApp.run(port=3000, debug=True)
