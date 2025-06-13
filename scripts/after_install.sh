#!/bin/bash
# Script chạy sau khi cài đặt

# Đặt quyền cho các tệp
chmod -R 755 /var/www/html

# Khởi động lại dịch vụ Apache
systemctl start apache2
systemctl enable apache2

# Ghi log thành công
echo "Triển khai thành công vào $(date)" >> /var/log/deployment.log
