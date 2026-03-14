FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Essential tools install karna
RUN apt-get update && apt-get install -y \
    sudo wget curl git bash neofetch \
    qemu-system qemu-utils cloud-image-utils \
    && rm -rf /var/lib/apt/lists/*

# sshx install karna (Ye aapko terminal link dega)
RUN curl -sSf https://sshx.io/get.sh | sh

# User setup
RUN useradd -m -s /bin/bash vpsadmin && echo "vpsadmin:vpsadmin" | chpasswd && adduser vpsadmin sudo
RUN echo "vpsadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/vpsadmin
USER vpsadmin

# Railway ko zinda rakhne ke liye aur sshx start karne ke liye script
CMD ["sh", "-c", "sshx"]
