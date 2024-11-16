# Use Ubuntu as the base image
FROM ubuntu:latest

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    python3-venv

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment and install Python packages inside it
RUN /opt/venv/bin/pip install --upgrade pip
RUN /opt/venv/bin/pip install PyYAML

# Copy the feed.py script into the container
COPY feed.py /usr/bin/feed.py

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set the virtual environment to be active
ENV PATH="/opt/venv/bin:$PATH"

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]