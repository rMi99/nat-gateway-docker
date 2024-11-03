# NAT Gateway Docker Project

This project sets up a Dockerized NAT Gateway on Amazon Linux 2023.

## Project Structure
- **Dockerfile**: Builds the NAT gateway Docker image.
- **start-nat.sh**: Configures NAT rules in the Docker container.
- **docs/**: Contains additional documentation.

## Usage
Build and run the Docker container with:
```bash
docker build -t nat-gateway .
docker run --privileged -d --network host nat-gateway
```

For detailed setup instructions, refer to `docs/setup-guide.md`.
