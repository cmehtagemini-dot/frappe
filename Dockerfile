FROM python:3.11-slim

WORKDIR /app

COPY . .

# Install frappe dependencies if requirements.txt exists, otherwise install frappe
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; else pip install --no-cache-dir frappe; fi

EXPOSE 8000

CMD ["python", "-m", "frappe.cli", "serve", "--port", "8000"]
