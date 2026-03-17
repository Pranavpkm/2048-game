# 2048 game - built by Pranav
FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y nginx zip curl && \
    apt-get clean

RUN curl -o /var/www/html/master.zip \
    https://codeload.github.com/gabrielecirulli/2048/zip/master && \
    cd /var/www/html && \
    unzip master.zip && \
    mv 2048-master/* . && \
    rm -rf 2048-master master.zip

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]