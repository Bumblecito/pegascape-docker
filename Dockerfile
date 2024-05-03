FROM docker.io/library/node:9.2

RUN git clone https://github.com/Bumblecito/PegaScape.git

ADD . /pegaswitch
WORKDIR /pegaswitch

RUN npm install

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

CMD node start.js --webapplet --ip "$HOST_IP" --host "$HOST_IP" 
