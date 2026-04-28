class Config:
    SECRET_KEY  = "trestristestrigrestragabantrigoenuntrigal"
    DEBUG       =True

class DevelopmentConfig(Config):
    MYSQL_HOST      = 'localhost'
    MYSQL_USER      ='root'
    MYSQL_PASSWORD  ='mysql'
    MYSQL_DB        = 'dreamybunny'
class MailConfig:
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
    MAIL_USERNAME = 'sofiacid5138@alumnos.udg.mx'
    MAIL_PASSWORD = 'kmardrizhpxgeasa'
    MAIL_DEFAULT_SENDER = 'sofiacid5138@alumnos.udg.mx'
    MAIL_ASCII_ATTACHMENTS = True
config = {
    'development':DevelopmentConfig,
    'mail':MailConfig
}