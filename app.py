from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from extensions import db, socketio, scheduler
from reservations import ReservationListResource
from reservations_update import ReservationResource
from maintenance_needed import MaintenanceNeededResource
from devices_suggestion import SuggestDeviceResource
import signal
import sys
import urllib.parse
import os


def create_app(config_name='default'):
    app = Flask(__name__)
    CORS(app, resources={r"/*": {"origins": "*"}})
    
    # تكوين سلسلة الاتصال
    connection_string = (
        "Driver={ODBC Driver 17 for SQL Server};"
        "Server=db17785.public.databaseasp.net;"
        "Database=db17785;"
        "UID=db17785;"
        "PWD=9t?TyP7#@6pX;"
        "Encrypt=no;"
        "TrustServerCertificate=yes;"
        "MultipleActiveResultSets=True;"
        "Connection Timeout=30;"
    )

    params = urllib.parse.quote_plus(connection_string)
    app.config['SQLALCHEMY_DATABASE_URI'] = f"mssql+pyodbc:///?odbc_connect={params}"
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
    # تعيين ترميز JSON إلى UTF-8
    app.config['JSON_AS_ASCII'] = False
    
    # إعداد APScheduler - تعطيل API لتجنب التعارض
    app.config['SCHEDULER_API_ENABLED'] = False
    app.config['SCHEDULER_TIMEZONE'] = 'UTC'
    app.config['SCHEDULER_DAEMON'] = False  
    
    db.init_app(app)
    socketio.init_app(app, 
                     cors_allowed_origins="*",
                     async_mode='threading',  
                     daemon=False)  
    scheduler.init_app(app)
    
    api = Api(app)
    # Reservation List Resource
    api.add_resource(ReservationListResource, '/reservations')
    api.add_resource(ReservationResource, '/reservations/<int:reservation_id>')

    # Maintenance Needed Resource
    api.add_resource(MaintenanceNeededResource, '/devices/maintenance-needed')

    # Suggest Device Resource
    api.add_resource(SuggestDeviceResource, '/devices/suggest/<int:device_id>')
    return app  # Return the app instance

app = create_app()  # Create the app instance globally

def cleanup_resources():
    with app.app_context():
        try:
            scheduler.shutdown()
            db.session.remove()
            db.engine.dispose()
        except Exception as e:
            print(f'Error during cleanup: {str(e)}')
    
def signal_handler(sig, frame):
    print('تم استلام إشارة إنهاء. جاري إغلاق التطبيق...')
    cleanup_resources()
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

if __name__ == '__main__':
    scheduler.start()
    
    try:
        port = int(os.environ.get('PORT', 5000))
        socketio.run(app, host='0.0.0.0', port=port, debug=False, use_reloader=False)
    except KeyboardInterrupt:
        print('تم إيقاف التطبيق بواسطة المستخدم')
    finally:
        cleanup_resources()

