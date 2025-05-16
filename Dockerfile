FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة وبرامج تشغيل SQL Server
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && apt-get clean

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] 
