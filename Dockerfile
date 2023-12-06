# Используем базовый образ с поддержкой Java (OpenJDK)
FROM openjdk:11-jre-slim

# Используем базовый образ Python с поддержкой Flask
FROM python:3.9

# Устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Копируем исходные файлы приложения
COPY . /app

# Определяем переменную среды для Flask, чтобы указать, какое приложение запускать
ENV FLASK_APP=app.py

# Определяем порт, который будет слушать Flask
EXPOSE 5000

# Устанавливаем Flyway
WORKDIR /flyway
RUN apt-get update && \
    apt-get install -y wait-for-it && \
    wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/7.0.0/flyway-commandline-7.0.0-linux-x64.tar.gz | tar xvz && \
    ln -s /flyway/flyway-7.0.0/flyway /usr/local/bin/flyway && \
    apt-get remove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Возвращаемся в /app
WORKDIR /app

# Запускаем миграцию приложения
CMD ["bash", "-c", "wait-for-it mysql:3306 -- flyway repair -url=jdbc:mysql://mysql:3306/sys -user=root -password=Qwerty_123 && flyway migrate -url=jdbc:mysql://mysql:3306/sys -user=root -password=Qwerty_123 -locations=filesystem:/app/sys && python -m flask run --host=0.0.0.0"]



