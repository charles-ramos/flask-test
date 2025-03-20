from flask import Blueprint, render_template, request, jsonify, session, current_app
import os

# Main routes blueprint
main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def index():
    """Home page route"""
    return render_template('index.html')

@main_bp.route('/about')
def about():
    """About page route"""
    return render_template('about.html')

# API routes blueprint
api_bp = Blueprint('api', __name__)

@api_bp.route('/health', methods=['GET'])
def health_check():
    """API health check endpoint"""
    return jsonify({
        "status": "ok",
        "message": "API is running"
    }), 200

@api_bp.route('/process', methods=['POST'])
def process_text():
    """Process text using language models"""
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    
    data = request.get_json()
    text = data.get('text', '')
    
    if not text:
        return jsonify({"error": "No text provided"}), 400
    
    # Here you would typically process the text using langchain or other ML libraries
    # For now, we'll just return a placeholder response
    result = {
        "processed": True,
        "text": text,
        "length": len(text),
        "summary": f"Processed {len(text)} characters of text"
    }
    
    return jsonify(result) 