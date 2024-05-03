FROM docker.io/library/node:9.2

ADD . /pegaswitch
WORKDIR /pegaswitch

RUN git clone https://github.com/Bumblecito/PegaScape.git

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

RUN npm install

CMD node start.js --webapplet --ip $IP_ADDR --host $IP_ADDR
