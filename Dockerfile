FROM docker.io/library/node:9.2

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

WORKDIR /opt/app

COPY . /opt/app/.

RUN npm install
RUN npm install pty.js

CMD node start.js --webapplet --ip $IP_ADDR --host $IP_ADDR
