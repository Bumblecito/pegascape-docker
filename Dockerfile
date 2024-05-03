FROM node:8

ARG IP_ADDR=192.168.1.110
ENV IP_ADDR= $IP_ADDR=

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

WORKDIR /opt/app

COPY . /opt/app/.

RUN rm -rf /opt/app/node_modules/
RUN mkdir -p /opt/node_modules
RUN ln -s /opt/node_modules/ /opt/app/.

RUN git clone https://github.com/Bumblecito/PegaScape.git .
RUN npm install

CMD ["npm", "node start.js --webapplet --ip $IP_ADDR --host $IP_ADDR"]
