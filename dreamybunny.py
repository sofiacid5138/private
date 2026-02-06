from flask import Flask,render_template,url_for

dreamybunnyApp = Flask(__name__)

@dreamybunnyApp.route('/')
def home():
    return render_template('home.html')

@dreamybunnyApp.route('/signup',methods=['GET','POST'])
def signup():
    return render_template('signup.html')

if __name__ == '__main__':
    dreamybunnyApp.run(port=2200,debug=True)
