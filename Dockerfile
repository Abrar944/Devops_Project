FROM python:3.10

WORKDIR /data

# Install required system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Ensure the requirements file is present
COPY requirements.txt /data/requirements.txt
RUN pip install --no-cache-dir -r /data/requirements.txt

# Copy project files
COPY . .

# Run database migrations
RUN python manage.py migrate || true  # Prevent build failure if DB is unavailable

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
