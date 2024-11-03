# NAT Gateway Docker Project

This project provides a Dockerized setup for a NAT (Network Address Translation) Gateway on an Amazon Linux 2023 instance. A NAT Gateway is useful for routing traffic from private subnets to the internet while keeping the originating IP address private.

## Project Structure

```
nat-gateway-docker/
├── Dockerfile           # Docker configuration file to build the NAT gateway
├── README.md            # Project documentation
├── start-nat.sh         # Script to configure NAT rules within the container
├── .gitignore           # Specifies files/folders to ignore in Git
└── docs/
    └── setup-guide.md   # Additional setup guide or documentation
```

## Prerequisites

- **Amazon Linux 2023**: This project assumes you’re running it on an Amazon Linux 2023 EC2 instance.
- **Docker**: Docker must be installed and running on the EC2 instance.
- **Git**: Required for cloning and managing the project repository.
- **GitHub SSH Access**: Set up SSH access for GitHub to push the project (if using SSH URLs).

## Project Setup

### 1. Clone the Repository

Clone this project to your Amazon Linux instance:

```bash
git clone git@github.com:rMi99/nat-gateway-docker.git
cd nat-gateway-docker
```

### 2. Enable IP Forwarding on the Host

Enable IP forwarding on the Amazon Linux host machine to allow NAT functionality:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

To make this setting persistent across reboots, add it to `/etc/sysctl.conf`:

```bash
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p  # Reload sysctl settings
```

### 3. Build the Docker Image

Use the following command to build the Docker image for the NAT Gateway:

```bash
docker build -t nat-gateway .
```

### 4. Run the Docker Container

Run the Docker container with elevated privileges and host networking:

```bash
docker run --privileged -d --network host nat-gateway
```

The `--privileged` flag allows the container to manage networking, and `--network host` enables the container to use the host's network interfaces, which is necessary for a NAT gateway.

## Usage

Once the Docker container is running, your Amazon Linux instance will act as a NAT Gateway. 

- **Traffic Routing**: Any traffic originating from devices or instances within the same VPC but from private subnets can be routed through this instance for internet access.
- **Logs**: Check container logs to confirm NAT operations are running as expected:

  ```bash
  docker logs $(docker ps -q --filter ancestor=nat-gateway)
  ```

### Stopping the NAT Gateway

To stop the NAT Gateway, simply stop and remove the Docker container:

```bash
docker stop $(docker ps -q --filter ancestor=nat-gateway)
docker rm $(docker ps -aq --filter ancestor=nat-gateway)
```

## Troubleshooting

### Error: Read-only file system for `/proc/sys/net/ipv4/ip_forward`

If you see an error like:

```
/proc/sys/net/ipv4/ip_forward: Read-only file system
```

This occurs because the Docker container cannot modify `/proc` settings. IP forwarding must be enabled on the host system before starting the container. See the **Enable IP Forwarding on the Host** section above.

### Checking IP Forwarding

To verify that IP forwarding is correctly enabled on the host:

```bash
sysctl net.ipv4.ip_forward
```

The output should be:

```
net.ipv4.ip_forward = 1
```

### Network Issues

If devices in your private subnets cannot access the internet through the NAT Gateway:

1. **Check Security Groups**: Ensure the security group attached to the EC2 instance allows outbound internet traffic.
2. **Check Route Tables**: The route table associated with the private subnets should have a route pointing to the NAT Gateway instance.

## Additional Documentation

For more in-depth setup instructions and configurations, refer to [`docs/setup-guide.md`](docs/setup-guide.md).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

