FROM node:8 

RUN git clone https://github.com/Ramzus/pegascape.git
EXPOSE 80
EXPOSE 53/UDP
EXPOSE 8100

WORKDIR /opt/app

COPY . /opt/app/.

RUN rm -rf /opt/app/node_modules/
RUN mkdir -p /opt/node_modules
RUN ln -s /opt/node_modules/ /opt/app/.

RUN npm install

CMD ["npm", "start"]
