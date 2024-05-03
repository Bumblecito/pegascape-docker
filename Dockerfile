FROM node:9.2

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

WORKDIR /opt/app
RUN git clone https://github.com/Bumblecito/PegaScape.git .

COPY . /opt/app/.

RUN rm -rf /opt/app/node_modules/
RUN mkdir -p /opt/node_modules
RUN ln -s /opt/node_modules/ /opt/app/.

RUN npm install

ARG HOST_IP=192.168.1.110
ENV HOST_IP $IP_ADDR

CMD node start.js --webapplet --ip $IP_ADDR --host IP_ADDR
