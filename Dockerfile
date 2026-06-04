FROM frappe/erpnext:latest

# Your custom code can go here if needed
# For now, just use the official image as-is
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy repository files
COPY . .

# Install Python packages from requirements if it exists
RUN if [ -f requirements.txt ]; then \
    pip install --no-cache-dir -r requirements.txt; \
    else \
    pip install --no-cache-dir frappe; \
    fi

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000')" || exit 1

# Start frappe
CMD ["python", "-m", "frappe.cli", "serve", "--host", "0.0.0.0", "--port", "8000"]
