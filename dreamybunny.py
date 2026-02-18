
from flask import Flask,render_template,url_for,request
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash
from config import config
from models.entities.User import User
from models.ModelUser import ModelUser
from flask_login import LoginManager,login_user,logout_user

dreamybunnyApp = Flask(__name__)
db             =MySQL(dreamybunnyApp)
adminUsuarios =LoginManager (dreamybunnyApp)

@adminUsuarios.user_loader
def cargarUsuario
    return ModelUser.get_by_id(db,id)
@dreamybunnyApp.route('/')
def home():
    return render_template('home.html')


@dreamybunnyApp.route('/signup',methods=['GET','POST'])
def signup():
    if request.method ==  'POST':
        nombre = request.form['nombre']
        correo = request.form['correo']
        clave = request.form ['clave']
        claveCifrada = generate_password_hash(clave)
        regUsuario = db.connection.cursor()
        regUsuario.execute("INSERT INTO usuario (nombre, correo, clave) VALUES (%s, %s, %s)",(nombre.upper(), correo, claveCifrada))
        db.connection.commit()
        regUsuario.close()
        db.connection.commit()
        return render_template('home.html')
    else:
        return render_template('signup.html')
    
@dreamybunnyApp.route('/signin',methods=['GET','POST'])
def signin():
    if request.method == 'POST':
        usuario = User(0,None,request.form['correo'], request.form ['clave'] None)
        usuarioAutenticado = ModelUser.signin(deb,usuario)
        if usuarioAutenticado is not None:
            if usuarioAutenticado.clave:
                login_user(usuarioAutenticado)
                if usuarioAutenticado.perfil == 'A'
                return render_template('admin.html')
            else:
                return render_template('usuario.html')
            else
                return 'contraseña incorrecta'
        else:
                return 'usuario inexistente'
    else:
        return render render_template('signin.html')

if __name__ == '__main__':
    dreamybunnyApp.config.from_object(config['development'])
    dreamybunnyApp.run(port=3000)
