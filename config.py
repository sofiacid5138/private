import os 


class Config:
    SECRET_KEY  = "trestristestrigrestragabantrigoenuntrigal"
    DEBUG       =True

class DevelopmentConfig(Config):
    """2"""
    MYSQL_HOST      = 'localhost'
    MYSQL_USER      ='root'
    MYSQL_PASSWORD  ='mysql'
    MYSQL_DB        = 'dreamybunny'
    MYSQL_HOST = os.environ.get('MYSQLHOST')
    MYSQL_USER = os.environ.get('MYSQLUSER')
    MYSQL_PASSWORD = os.environ.get('MYSQLPASSWORD')
    MYSQL_DB = os.environ.get('MYSQLDATABASE')
    MYSQL_PORT = int(os.environ.get('MYSQLPORT', 3306))
class MailConfig:
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
    MAIL_USERNAME = 'sofiacid5138@alumnos.udg.mx'
    MAIL_PASSWORD = 'kmar driz hpxg easa'
    MAIL_DEFAULT_SENDER = 'sofiacid5138@alumnos.udg.mx'
    MAIL_ASCII_ATTACHMENTS = True
config = {
    'development':DevelopmentConfig,
    'mail':MailConfig
}