# This version of Linux has Node already installed
ARG NODE_VERSION=16.20.2
FROM node:${NODE_VERSION}-alpine
LABEL version=0.1
# Checking for updates & adding git and docker
RUN apk update
RUN apk upgrade
RUN apk add git
RUN apk add docker
#work Directory
WORKDIR /usr/src
#Cloning git file to folder
RUN git clone --depth=1 https://github.com/Solarleaf/liatrio-apprentice.git
WORKDIR /usr/src/liatrio-apprentice
# Dependency install
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev
# Run the application as a non-root user.
USER node
# Expose the port that the application listens on.
EXPOSE 80
# Run the application.
CMD node index.js
