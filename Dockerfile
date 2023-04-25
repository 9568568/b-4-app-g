FROM node:latest
EXPOSE 3000
ENV TZ=Asia/Shanghai
WORKDIR /app
#ADD file.tar.gz /app/
COPY *.* /app/

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js status-client

ENTRYPOINT [ "node", "server.js" ]
