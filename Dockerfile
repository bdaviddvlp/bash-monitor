# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl

# Copy the entire project to the container
COPY . /app

# Set the entrypoint to run the script
ENTRYPOINT ["/app/init_monitor.sh"]