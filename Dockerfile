FROM docker.io/library/node:9.2

EXPOSE 53
EXPOSE 80
EXPOSE 8100

WORKDIR /opt/app

COPY . /opt/app/.

RUN npm install
RUN npm install pty.js

CMD ["npm", "start"]
