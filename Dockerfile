FROM phusion/baseimage:bionic-1.0.0
ENV pip_packages "pipenv ansible pyopenssl"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       apt-utils \
       python3-setuptools \
       python3-pip \
       python-pip \
       ca-certificates \
       software-properties-common \
       openjdk-8-jdk-headless \
       openssh-server \
       net-tools systemd systemd-cron sudo \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible via Pip.
RUN pip3 install -U pip
RUN pip3 install $pip_packages

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/sbin/my_init"]
