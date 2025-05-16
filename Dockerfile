FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    && apt-get clean

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV PORT=5000

# فتح المنفذ المستخدم
EXPOSE 5000

# تشغيل التطبيق
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:5000", "run_production:app"] 