FROM node:8

RUN git clone https://github.com/Ramzus/pegascape.git .

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

RUN npm install

CMD ["npm", "node start.js --webapplet --ip $IP_ADDR --host $IP_ADDR"]
