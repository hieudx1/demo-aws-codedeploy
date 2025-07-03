#!/bin/bash
set -e

echo "=== After Install Script Started ==="

# Set permissions
echo "Setting permissions..."
sudo chmod -R 755 /usr/share/nginx/html
sudo chown -R nginx:nginx /usr/share/nginx/html

# Verify port 80 is free before starting
echo "Checking port 80 availability..."
if sudo netstat -tlnp | grep :80; then
    echo "ERROR: Port 80 is still occupied"
    sudo netstat -tlnp | grep :80
    exit 1
fi

# Enable nginx
sudo systemctl enable nginx

# Start nginx
echo "Starting nginx..."
sudo systemctl start nginx

# Wait and check
sleep 3

if sudo systemctl is-active --quiet nginx; then
    echo "SUCCESS: Nginx is running"
    echo "Port 80 status:"
    sudo netstat -tlnp | grep :80
    curl -I localhost || echo "Warning: Could not test localhost"
else
    echo "ERROR: Nginx failed to start"
    sudo systemctl status nginx
    sudo journalctl -xeu nginx.service --no-pager
    exit 1
fi

echo "Deployment completed at $(date)" | sudo tee -a /var/log/deployment.log
echo "=== After Install Script Completed ==="