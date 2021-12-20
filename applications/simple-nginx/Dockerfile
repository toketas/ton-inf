FROM nginx:1.21.4

COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY html/sample.html /usr/share/nginx/html/index.html

COPY snippets/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY snippets/self-signed.conf /etc/nginx/snippets/self-signed.conf

COPY certs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY certs/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY certs/dhparam.pem /etc/ssl/certs/dhparam.pem

EXPOSE 443
