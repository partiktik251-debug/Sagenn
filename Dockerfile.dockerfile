# Base Image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies (ffmpeg is required for moviepy)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

# Expose port (Render sets $PORT env var)
EXPOSE 8501

# Command to run the app
CMD streamlit run app.py --server.port=$PORT --server.address=0.0.0.0
