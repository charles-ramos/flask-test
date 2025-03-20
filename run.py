from flask import Flask, render_template, request, jsonify, session
from flask_session import Session
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Initialize Flask app
app = Flask(__name__)

# Configure Flask app
app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY", "dev-key-123")
app.config["SESSION_TYPE"] = "filesystem"
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_USE_SIGNER"] = True

# Initialize Flask extensions
Session(app)

# Import routes after initializing app
from app.routes import main_bp, api_bp

# Register blueprints
app.register_blueprint(main_bp)
app.register_blueprint(api_bp, url_prefix='/api')

if __name__ == "__main__":
    # Run the app in debug mode if not in production
    debug_mode = os.environ.get("FLASK_ENV", "development") != "production"
    app.run(host="0.0.0.0", port=8080, debug=debug_mode) 