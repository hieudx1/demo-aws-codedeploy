#!/bin/bash
# Script chạy sau khi cài đặt

# Đặt quyền cho các tệp
sudo chmod -R 755 /usr/share/nginx/html
sudo chown -R nginx:nginx /usr/share/nginx/html

# Enable và khởi động nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Kiểm tra trạng thái nginx
if sudo systemctl is-active --quiet nginx; then
    echo "Nginx đã khởi động thành công"
else
    echo "Lỗi: Nginx không thể khởi động"
    sudo systemctl status nginx
    exit 1
fi

# Ghi log thành công
echo "Triển khai thành công vào $(date)" | sudo tee -a /var/log/deployment.log