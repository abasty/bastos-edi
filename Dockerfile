FROM debian:13-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    python3 \
    python3-venv \
    python3-pip \
    vsftpd \
    curl \
    wget \
    git

# Create virtual environment and install esptool
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN /opt/venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel && \
    /opt/venv/bin/pip install --no-cache-dir esptool

# # Install websocat
# RUN apt-get update && apt-get install -y \
#     websocat \
#     && rm -rf /var/lib/apt/lists/*

# Create bastos data directory
RUN mkdir -p /data/bastos && chmod 777 /data/bastos

# Copy SPA files
COPY app/ /app/app/
COPY css/ /app/css/
COPY font/ /app/font/
COPY icon/ /app/icon/
COPY import/ /app/import/
COPY library/ /app/library/
COPY sound/ /app/sound/
COPY index.html /app/index.html

# Copy bastos-edi scripts
COPY bastos-edi.sh /app/bastos-edi.sh
COPY bastos-edi.py /app/bastos-edi.py
RUN chmod +x /app/bastos-edi.sh /app/bastos-edi.py

# Copy binaries (if exists)
RUN mkdir -p /usr/local/bin
COPY bin/* /usr/local/bin/

# Configure vsftpd
RUN mkdir -p /etc/vsftpd && \
    echo "listen=YES" > /etc/vsftpd/vsftpd.conf && \
    echo "anonymous_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "local_enable=NO" >> /etc/vsftpd/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "anon_upload_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "anon_mkdir_write_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "anon_other_write_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "anon_root=/data/bastos" >> /etc/vsftpd/vsftpd.conf && \
    echo "no_anon_password=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "hide_ids=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "pasv_enable=YES" >> /etc/vsftpd/vsftpd.conf && \
    echo "pasv_min_port=30000" >> /etc/vsftpd/vsftpd.conf && \
    echo "pasv_max_port=30100" >> /etc/vsftpd/vsftpd.conf

# Create vsftpd lock file
RUN touch /var/run/vsftpd.pid && chmod 777 /var/run/vsftpd.pid

# Set disk folder
RUN mkdir -p /app/disk && chmod 777 /app/disk

# Start script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
