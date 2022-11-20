# docker-compose-raspberry-server

nginx config is missing, f.e:

# on alpine, copy to /etc/nginx/nginx.conf
user                            root;
worker_processes                auto;

error_log                       /var/log/nginx/error.log warn;

events {
    worker_connections          1024;
}

http {
    include                     /etc/nginx/mime.types;
    default_type                application/octet-stream;
    sendfile                    off;
    access_log                  off;
    keepalive_timeout           3000;
    server {
        server_name             localhost;
        listen                  3000;
        client_max_body_size    16m;
        location / {
            root                    /usr/share/nginx/html;
            index                   index.html index.htm;
            try_files               $uri $uri/ /index.html;
        }
    }

}
