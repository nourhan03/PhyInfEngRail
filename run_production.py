import signal
import sys
import os
from app import create_app
from extensions import socketio, db

# إنشاء تطبيق Flask
app = create_app()

# استخدام رقم ثابت للمنفذ (5000) بدلاً من متغير البيئة
port = 5000

def signal_handler(sig, frame):
    """معالجة إشارات الإنهاء لإغلاق التطبيق بشكل نظيف"""
    print('تم استلام إشارة إنهاء. جاري إغلاق التطبيق...')
    
    # إغلاق اتصالات قاعدة البيانات
    db.session.remove()
    db.engine.dispose()
    
    sys.exit(0)

# تسجيل معالجات الإشارات
signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

if __name__ == '__main__':
    try:
        socketio.run(app, host='0.0.0.0', port=port, debug=False, use_reloader=False)
    except KeyboardInterrupt:
        print('تم إيقاف التطبيق بواسطة المستخدم')
    finally:
        # إغلاق اتصالات قاعدة البيانات
        db.session.remove()
        db.engine.dispose() 
