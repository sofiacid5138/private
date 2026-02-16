
from flask import Flask,render_template,url_for,request
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash
from config import config

dreamybunnyApp = Flask(__name__)
db             =MySQL(dreamybunnyApp)

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

if __name__ == '__main__':
    dreamybunnyApp.config.from_object(config['development'])
    dreamybunnyApp.run(port=2200)
