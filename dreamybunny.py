
from flask import Flask,render_template,url_for,request
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash
from config import Config

dreamybunnyApp = Flask(__name__)
db             =MySQL(dreamybunnyApp)

@dreamybunnyApp.route('/')
def home():


@dreamybunnyApp.route('/signup',methods=['GET','POST'])
def signup():


if request.form ==  'POST':
    nombre = request.form['nombre']
    correo = request.form['correo']
    clave = requets.form ['clave']
    claveCifrada = generate_password_hash(clave)
    regUsuario = db.connection.cursor()
    regUsuario.execute("INSERT INTO usuario (nombre, correo, clave) VALUES (%s, %s, %s)",(nombre.upper(), correo, claveCifrada))
    db.connection.commit()
    regUsuario.close()
    return render_template('home.html')
else:
    return render_template('signup.html')

if __name__ == '__main__':
    @dreamybunnyApp.config.fromobject(config[development])
    dreamybunnyApp.run(port=2200,debug=True)
