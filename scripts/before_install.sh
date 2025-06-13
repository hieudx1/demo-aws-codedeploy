#!/bin/bash
# Script chạy trước khi cài đặt

# Cài đặt các gói cần thiết nếu chưa có
if ! [ -x "$(command -v nginx)" ]; then
  echo 'Đang cài đặt Nginx...'
  if [ -f /etc/redhat-release ]; then
    # CentOS/RHEL/Amazon Linux
    sudo amazon-linux-extras install nginx1 -y || sudo yum install -y nginx
  elif [ -f /etc/debian_version ]; then
    # Ubuntu/Debian
    sudo apt-get update
    sudo apt-get install -y nginx
  fi
fi

# Dừng dịch vụ Nginx để chuẩn bị cập nhật
sudo systemctl stop nginx || sudo service nginx stop

# Tạo thư mục nếu chưa tồn tại
if [ ! -d /usr/share/nginx/html ]; then
  sudo mkdir -p /usr/share/nginx/html
fi

# Sao lưu phiên bản cũ nếu có
if [ -f /usr/share/nginx/html/index.html ]; then
  sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
fi
