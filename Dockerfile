# https://github.com/UKPLab/EasyNMT/blob/5ea48f5fb68be9e4be4b8096800e32b8ad9a45df/docker/api/cpu.dockerfile#L5

FROM python:3.10-slim

# Install build dependencies and curl
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential \
#     curl \
#     && rm -rf /var/lib/apt/lists/*

# RUN apt-get install libgl1-mesa-glx  

# Working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt requirements.txt
# Create a Python virtual environment  
RUN python -m venv /opt/venv  

# Activate the virtual environment by updating the PATH  
ENV PATH="/opt/venv/bin:$PATH"  

RUN pip install --upgrade pip
# RUN pip install --no-cache-dir Flask==3.0.3 gunicorn Flask-Session==0.5.0 Flask-SQLAlchemy==3.0.2 
# RUN pip install --no-cache-dir langchain==0.2.0 langchain-community==0.2.0 langchain-core==0.2.10 langchain-openai==0.1.7 
# RUN pip install --no-cache-dir langchain-groq==0.1.6 langchain-mistralai==0.1.9 langchain-huggingface==0.0.3 sentence-transformers==3.4.1  
# RUN pip install --no-cache-dir transformers==4.49.0 langchainhub==0.1.21 langgraph==0.1.1 faiss-cpu==1.10.0 rank_bm25==0.2.2 colorama==0.4.6   
# RUN pip install --no-cache-dir python-dotenv==1.0.1 pyvis==0.3.2 graphviz==0.20.3 grandalf==0.8 pandas Pillow regex requests SQLAlchemy==2.0.39  
# RUN pip install --no-cache-dir stqdm tqdm pdfplumber pdf2image mistralai==1.5.1 opencv-python==4.11.0.86

RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project files
COPY . .

# Expose the server port
EXPOSE 8080

# Command to start the server
CMD ["gunicorn", "--timeout", "2000", "-b", "0.0.0.0:8080", "run:app"] 
# CMD ["sh", "-c", "gunicorn -b 0.0.0.0:8080 --timeout 100 --workers $(($(nproc --all) * 2 + 1)) run:app"]

