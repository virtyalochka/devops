# Используем базовый образ Python с поддержкой Flask
FROM python:3.9

# Устанавливаем зависимости
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install pylint bandit

# Копируем исходные файлы приложения
COPY app app

RUN pylint --output-format=parseable /app/*.py
RUN bandit -r /app/.

# Определяем переменную среды для Flask, чтобы указать, какое приложение запускать
ENV FLASK_APP=app.py

# Определяем порт, который будет слушать Flask
EXPOSE 5000

# Запускаем приложение Flask
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]