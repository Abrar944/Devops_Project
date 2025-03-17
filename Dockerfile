FROM python:3.10  # Use a stable Python version

WORKDIR /data

# Install required system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Copy and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files after dependencies are installed
COPY . .

# Run database migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
