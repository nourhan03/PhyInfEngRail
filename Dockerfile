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
    && curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get clean

# إضافة مسار odbcinst.ini لتجنب مشاكل ODBC
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.*.so.*.*.* \nUsageCount=1" >> /etc/odbcinst.ini

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV ODBCSYSINI=/etc
ENV ODBCINI=/etc/odbc.ini

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة وبرامج تشغيل SQL Server
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get clean

# إضافة مسار odbcinst.ini لتجنب مشاكل ODBC
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.*.so.*.*.* \nUsageCount=1" >> /etc/odbcinst.ini

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV ODBCSYSINI=/etc
ENV ODBCINI=/etc/odbc.ini

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة وبرامج تشغيل SQL Server
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get clean

# إضافة مسار odbcinst.ini لتجنب مشاكل ODBC
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.*.so.*.*.* \nUsageCount=1" >> /etc/odbcinst.ini

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV ODBCSYSINI=/etc
ENV ODBCINI=/etc/odbc.ini

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة وبرامج تشغيل SQL Server
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get clean

# إضافة مسار odbcinst.ini لتجنب مشاكل ODBC
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.*.so.*.*.* \nUsageCount=1" >> /etc/odbcinst.ini

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV ODBCSYSINI=/etc
ENV ODBCINI=/etc/odbc.ini

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] FROM python:3.9-slim

# إعداد بيئة العمل
WORKDIR /app

# تثبيت حزم نظام التشغيل المطلوبة وبرامج تشغيل SQL Server
RUN apt-get update && apt-get install -y \
    gnupg \
    curl \
    build-essential \
    unixodbc-dev \
    apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools \
    && apt-get clean

# إضافة مسار odbcinst.ini لتجنب مشاكل ODBC
RUN echo "[ODBC Driver 17 for SQL Server]\nDescription=Microsoft ODBC Driver 17 for SQL Server\nDriver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.*.so.*.*.* \nUsageCount=1" >> /etc/odbcinst.ini

# نسخ ملف المتطلبات وتثبيت المكتبات
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn eventlet

# نسخ كود المشروع
COPY . .

# تعيين متغيرات البيئة
ENV PYTHONUNBUFFERED=1
ENV ODBCSYSINI=/etc
ENV ODBCINI=/etc/odbc.ini

# فتح المنفذ المستخدم
EXPOSE 8080

# تشغيل التطبيق على منفذ 8080
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "--bind", "0.0.0.0:8080", "run_production:app"] 
