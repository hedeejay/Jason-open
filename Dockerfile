FROM 10.114.72.21:5001/basicimages/nginx:v1.4
MAINTAINER hedj "hedj-ds@petrochina.com.cn"
RUN sed -i '1 i\user root;' /etc/nginx/nginx.conf 
COPY _book /var/www/html/website/dist