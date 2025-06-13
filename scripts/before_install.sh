#!/bin/bash
# Script chạy trước khi cài đặt

# Cài đặt các gói cần thiết nếu chưa có
if ! [ -x "$(command -v apache2)" ]; then
  echo 'Đang cài đặt Apache...'
  apt-get update
  apt-get install -y apache2
fi

# Dừng dịch vụ Apache để chuẩn bị cập nhật
systemctl stop apache2

# Tạo thư mục nếu chưa tồn tại
if [ ! -d /var/www/html ]; then
  mkdir -p /var/www/html
fi

# Sao lưu phiên bản cũ nếu có
if [ -f /var/www/html/index.html ]; then
  mv /var/www/html/index.html /var/www/html/index.html.bak
fi
