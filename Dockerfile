# Используем базовый образ Python с поддержкой Flask
FROM python:3.9

# Устанавливаем зависимости
WORKDIR /app

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходные файлы приложения
COPY app app

# Выполняем статический анализ кода
RUN pip install pylint bandit
RUN pylint --output-format=parseable /app/*.py
RUN bandit -r /app

# Определяем переменную среды для Flask, чтобы указать, какое приложение запускать
ENV FLASK_APP=app/app.py

# Определяем порт, который будет слушать Flask
EXPOSE 5000

# Запускаем приложение Flask
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]