#!/bin/bash

# Start vsftpd in the background
echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &
VSFTPD_PID=$!

# Start the bastos-edi.sh script
echo "Starting BASTOS-EDI server..."
cd /app
exec /app/bastos-edi.sh

# If bastos-edi.sh exits, kill vsftpd
kill $VSFTPD_PID 2>/dev/null || true
