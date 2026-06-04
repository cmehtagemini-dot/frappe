FROM frappe/frappe:latest

WORKDIR /app

# Install system dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy repository files
COPY . .

# Expose ports
EXPOSE 8000 8001

# Start frappe
CMD ["bench", "start"]
