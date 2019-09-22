server {
    listen 443 ssl http2;
    server_name vas.submin.ru;
    server_name_in_redirect off;

    access_log /var/log/nginx/vas.submin.ru-access.log;
    error_log /var/log/nginx/vas.submin.ru-error.log;

    root /var/www/static/vas-tracking/;

    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
