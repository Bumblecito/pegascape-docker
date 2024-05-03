FROM docker.io/library/node:9.2 AS builder

WORKDIR /opt/app
RUN git clone https://github.com/Bumblecito/PegaScape.git
RUN npm install

EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

RUN groupadd -r pegascape && useradd --no-log-init -r -g pegascape pegascape

WORKDIR /opt/app
COPY --from=builder /opt/app ./

RUN chown -R pegascape:pegascape /opt/app

CMD node start.js --webapplet --ip $IP_ADDR --host $IP_ADDR
