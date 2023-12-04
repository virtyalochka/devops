# Используем базовый образ Python с поддержкой Flask
FROM python:3.9

# Устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
# Install flyway
RUN wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.11.0/flyway-commandline-7.11.0-linux-x64.tar.gz | tar xvz -C /opt \
  && ln -s /opt/flyway-7.11.0/flyway /usr/local/bin/flyway

# Копируем исходные файлы приложения
COPY . /app

# Определяем переменную среды для Flask, чтобы указать, какое приложение запускать
ENV FLASK_APP=app.py

# Определяем порт, который будет слушать Flask
EXPOSE 5000

# Запускаем приложение Flask
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
