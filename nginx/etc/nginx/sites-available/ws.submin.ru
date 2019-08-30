server {
    listen  443 ssl;
    server_name ws.submin.ru;

    location /trans/ {
        proxy_pass http://translator:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }
}
