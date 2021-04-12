FROM mongo:latest
WORKDIR server-conf/mongo
COPY ./docker-entrypoint-initdb.d/mongo-init.js /docker-entrypoint-initdb.d/mongo-init.js
RUN chmod 755 /docker-entrypoint-initdb.d/mongo-init.js
RUN chmod +x /docker-entrypoint-initdb.d/mongo-init.js