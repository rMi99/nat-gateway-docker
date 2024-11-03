# Dockerfile for NAT Gateway
FROM amazonlinux:2023

# Install required tools
RUN yum update -y && \
    yum install -y iptables iproute

# Enable IP forwarding
RUN echo 1 > /proc/sys/net/ipv4/ip_forward

# Script for NAT configuration
COPY start-nat.sh /usr/local/bin/start-nat.sh
RUN chmod +x /usr/local/bin/start-nat.sh

CMD ["/usr/local/bin/start-nat.sh"]