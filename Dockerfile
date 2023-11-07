# # Use the official Ubuntu image as the base image
# FROM ubuntu:latest

# # Set environment variables to avoid interaction during installation
# ENV DEBIAN_FRONTEND=noninteractive

# # Update the package repository and install necessary packages
# RUN apt-get update -y && apt-get install -y python3-pip

# # Copy your FastAPI application code into the container
# COPY main.py /main.py

# # Install FastAPI and Uvicorn (ASGI server)
# RUN pip3 install fastapi uvicorn

# # Expose the FastAPI application port
# EXPOSE 8000

# # Start the FastAPI application using Uvicorn
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# Builder Stage
FROM python:3.9-alpine AS builder
WORKDIR /app
COPY main.py /app/
RUN pip3 install --no-cache-dir fastapi uvicorn

# Final Stage
FROM python:3.9-alpine
COPY --from=builder /app /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
