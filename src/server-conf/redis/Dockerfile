FROM redis:alpine
WORKDIR server-conf/redis
COPY redis.conf /usr/local/etc/redis/redis.conf
COPY init.sh ./
RUN chmod 755 init.sh
RUN chmod +x init.sh