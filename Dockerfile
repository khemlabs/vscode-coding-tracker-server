############################################################
# Dockerfile to build Code traking server
# Based on Node Alpine
############################################################

FROM node:alpine AS base
# Install Global dependencies
RUN npm i npm pm2 -g
# Copy package json (lock file could be added to with *) and Install
COPY --chown=node:node package.json /app/


FROM base AS dependencies
# Set Working dir and user
WORKDIR /app
# Install Dependencies on temp folder and clean cache
RUN npm install && npm cache clean --force
# Copy app files
COPY --chown=node:node . .
# Create data directory
VOLUME [ "/app", "/data" ]
RUN chown -R node:node /app /data & chmod -R ug+rwx /app /data & chmod -R ug+s /app /data
# Change to working user
USER node


FROM dependencies AS release
# Set ARG and ENV vars
ARG __SECRET__TOKEN=12345
ARG SERVER_PORT=3000
ENV __SECRET__TOKEN ${__SECRET__TOKEN}
ENV SERVER_PORT ${SERVER_PORT}
# Working Port
EXPOSE ${SERVER_PORT}
# Run command
CMD ["pm2-runtime", "start", "ecosystem.config.js"]