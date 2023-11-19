# Используем базовый образ Python с поддержкой Flask
FROM python:3.9

# Устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Копируем исходные файлы приложения
COPY app app

# Определяем переменную среды для Flask, чтобы указать, какое приложение запускать
ENV FLASK_APP=app.py

# Определяем порт, который будет слушать Flask
EXPOSE 5000

# Запускаем приложение Flask
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
