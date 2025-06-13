#!/bin/bash
# Script chạy sau khi cài đặt

# Đặt quyền cho các tệp
sudo chmod -R 755 /usr/share/nginx/html

# Khởi động lại dịch vụ Nginx
sudo systemctl start nginx || sudo service nginx start
sudo systemctl enable nginx || sudo chkconfig nginx on

# Ghi log thành công
echo "Triển khai thành công vào $(date)" | sudo tee -a /var/log/deployment.log
