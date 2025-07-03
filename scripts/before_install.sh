#!/bin/bash
set -e

echo "=== Before Install Script Started ==="

# Cài đặt nginx nếu chưa có
if ! command -v nginx &> /dev/null; then
    echo "Installing Nginx..."
    sudo yum update -y
    sudo yum install -y nginx
    echo "Nginx installed successfully"
fi

# Kill tất cả process đang dùng port 80
echo "Checking for processes using port 80..."
if sudo lsof -ti:80; then
    echo "Killing processes using port 80..."
    sudo lsof -ti:80 | xargs sudo kill -9 || true
    sleep 2
fi

# Stop nginx (nếu đang chạy)
echo "Stopping nginx..."
sudo systemctl stop nginx 2>/dev/null || true
sudo pkill -f nginx || true
sleep 2

# Double check port 80 is free
if sudo netstat -tlnp | grep :80; then
    echo "Warning: Port 80 still in use, attempting to free it..."
    sudo fuser -k 80/tcp || true
    sleep 2
fi

# Create directory
echo "Creating directory..."
sudo mkdir -p /usr/share/nginx/html

# Backup old files
if [ -f /usr/share/nginx/html/index.html ]; then
    echo "Backing up old index.html..."
    sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
fi

echo "=== Before Install Script Completed ==="