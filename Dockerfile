FROM ubuntu:22.04

# Non-interactive mode taaki install ke waqt rukey nahi
ENV DEBIAN_FRONTEND=noninteractive

# 1. Saare Tools Install karein (QEMU, Cloud-utils, Wget, Docker)
RUN apt-get update && apt-get install -y \
    sudo wget curl git bash \
    qemu-system qemu-utils cloud-image-utils \
    neofetch vim nano net-tools \
    python3 python3-pip \
    docker.io \
    xfce4 xfce4-goodies tightvncserver novnc websockify \
    && rm -rf /var/lib/apt/lists/*

# 2. Root Access & User Setup
RUN useradd -m -s /bin/bash vpsadmin && echo "vpsadmin:vpsadmin" | chpasswd && adduser vpsadmin sudo
RUN echo "vpsadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 3. KVM Permissions Fix (Crucial Step)
# Container ke andar KVM access dilaane ki koshish
RUN usermod -aG kvm vpsadmin || true

# 4. Working Directory
WORKDIR /home/vpsadmin
USER vpsadmin

# 5. Environment Setup (VM script ke liye tyari)
RUN mkdir -p /home/vpsadmin/vms

# Railway port expose
EXPOSE 8080

# 6. Startup Command (Code-server ya Desktop chalu karne ke liye)
# Filhal hum isse as a terminal zinda rakhenge taaki aap script run kar sakein
CMD ["/bin/bash", "-c", "sleep infinity"]
