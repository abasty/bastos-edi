#!/bin/bash

# Generate vsftpd config as current user
echo "Generating vsftpd configuration..."
mkdir -p /tmp/vsftpd
cat > /tmp/vsftpd/vsftpd.conf << 'EOF'
listen=NO
listen_ipv6=YES
listen_port=9021
run_as_launching_user=YES
anonymous_enable=YES
write_enable=YES
anon_umask=0
anon_upload_enable=YES
anon_root=/app
anon_other_write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
log_ftp_protocol=YES
vsftpd_log_file=/tmp/vsftpd/vsftpd.log
xferlog_file=/tmp/vsftpd/xferlog
pasv_enable=Yes
ftpd_banner=BASTOS Remote Disk
secure_chroot_dir=/var/run/vsftpd/empty
ssl_enable=NO
EOF

# Start vsftpd in the background with the generated config
echo "Starting vsftpd..."
/usr/sbin/vsftpd /tmp/vsftpd/vsftpd.conf &
VSFTPD_PID=$!

# Start the bastos-edi.sh script
echo "Starting BASTOS-EDI server..."
cd /app
exec /app/bastos-edi.sh

# If bastos-edi.sh exits, kill vsftpd
kill $VSFTPD_PID 2>/dev/null || true
