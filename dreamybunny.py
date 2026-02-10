from flask import Flask,render_template,url_for,request
from werkzeug.security import generate_password_hash

dreamybunnyApp = Flask(__name__)

@dreamybunnyApp.route('/')
def home():
    return render_template('home.html')

@dreamybunnyApp.route('/signup',methods=['GET','POST'])
def signup():
    return render_template('signup.html')

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


if __name__ == '__main__':
    dreamybunnyApp.run(port=2200,debug=True)
