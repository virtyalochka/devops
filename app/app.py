from flask import Flask, render_template, send_from_directory
from prometheus_client import Counter, generate_latest, REGISTRY
from mysql_db import MySQL

app = Flask(__name__)

app.config.from_pyfile('config.py')

db = MySQL(app)

from auth import bp as auth_bp, init_login_manager
from books import bp as books_bp
from collect import bp as collections_bp

app.register_blueprint(auth_bp)
app.register_blueprint(books_bp)
app.register_blueprint(collections_bp)

init_login_manager(app)

# Define Prometheus metrics
http_requests_total = Counter('http_requests_total', 'Total number of HTTP requests')
function_calls_total = Counter('function_calls_total', 'Total number of function calls with labels', labelnames=['endpoint'])
errors_total = Counter('errors_total', 'Total number of errors with labels', labelnames=['endpoint'])

def increment_function_calls(endpoint):
    function_calls_total.labels(endpoint=endpoint).inc()

def increment_errors(endpoint):
    errors_total.labels(endpoint=endpoint).inc()

@app.route('/')
def index():
    http_requests_total.inc()  # Increment the HTTP request counter
    try:
        # Your existing code for the index function

        # Increment the function call counter for the index function
        increment_function_calls('index')
        return render_template('index.html')
    except Exception as e:
        # Increment the error counter for the index function
        increment_errors('index')
        raise e

@app.route('/media/<path:filename>')
def media(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename, mimetype='image/jpeg')

# Endpoint for Prometheus to scrape metrics
@app.route('/metrics')
def metrics():
    return generate_latest(REGISTRY), 200, {'Content-Type': 'text/plain'}

