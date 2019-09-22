server {
    listen 443 ssl http2;
    server_name vas-admin.submin.ru;
    server_name_in_redirect off;

    access_log /var/log/nginx/vas-admin.submin.ru-access.log;
    error_log /var/log/nginx/vas-admin.submin.ru-error.log;

    location /static/ {
        alias /var/www/static/vas-admin/;
    }

    location /media/ {
        alias /var/www/media/vas-admin/;
    }

    location / {
        proxy_pass http://admin:8000;
        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
    }
}
