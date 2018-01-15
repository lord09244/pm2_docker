FROM keymetrics/pm2:6-alpine

# Bundle APP files
RUN mkdir -p logs
COPY src src/
COPY package.json .
COPY pm2.json .

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install --production
RUN pm2 install pm2-server-monit
# Show current folder structure in logs
RUN ls -al -R

CMD [ "pm2-runtime", "start", "pm2.json" ]
