#!/bin/bash
# Script chạy trước khi cài đặt

# Cài đặt nginx cho Amazon Linux 2
if ! [ -x "$(command -v nginx)" ]; then
  echo 'Đang cài đặt Nginx...'
  sudo yum update -y
  sudo yum install -y nginx
fi

# Dừng dịch vụ Nginx để chuẩn bị cập nhật
sudo systemctl stop nginx 2>/dev/null || true

# Tạo thư mục nếu chưa tồn tại
sudo mkdir -p /usr/share/nginx/html

# Sao lưu phiên bản cũ nếu có
if [ -f /usr/share/nginx/html/index.html ]; then
  sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
fi