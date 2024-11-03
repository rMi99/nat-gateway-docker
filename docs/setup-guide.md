# Setup Guide for NAT Gateway Docker Project

This guide provides detailed instructions for setting up and configuring the Dockerized NAT Gateway.

## Steps
1. Build the Docker image using the Dockerfile.
2. Run the Docker container with elevated privileges and host networking.

## Commands
```bash
docker build -t nat-gateway .
docker run --privileged -d --network host nat-gateway
```
