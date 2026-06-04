FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy repository files
COPY . .

# Install frappe framework and dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir frappe-bench && \
    pip install --no-cache-dir frappe

# Expose port
EXPOSE 8000

# Start frappe development server
CMD ["python", "-m", "frappe.cli", "serve", "--host", "0.0.0.0", "--port", "8000"]
