# 1. Use an official Python runtime as a parent image.
# The readme.md specifies Python 3.10+, so 3.11 is a good, stable choice.
# The -slim variant is a good balance for size and compatibility.
FROM python:3.13.5-alpine3.22

# 2. Set environment variables to prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Set the working directory in the container
WORKDIR /app

# 4. Copy the dependencies file and install them.
# Copying requirements.txt first leverages Docker's layer caching.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application's code into the container
COPY . .

# 6. Expose the port the app runs on
EXPOSE 8000

# 7. Define the command to run the app when the container starts.
# Use 0.0.0.0 to make the server accessible from outside the container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
