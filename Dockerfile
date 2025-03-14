# Build Stage

# apprentice-action / action/yaml is using node-version '16' so using 16.20.2
ARG NODE_VERSION=16.20.2
FROM node:${NODE_VERSION}-alpine AS builder

# Labels
LABEL version=0.1
LABEL description="Liatrio API"
LABEL maintainer="L"

# Checking for updates & adding git and docker
RUN apk update && apk upgrade && apk add git && apk add docker
#work Directory
WORKDIR /usr/src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
# Using production for now since not using any Dev tools in this area, for now
# RUN npm install --production
RUN npm ci --omit=dev

# Rest of code
COPY . .

# Run stage
FROM node:16.20.2-alpine

# Environmental Varaibles
ENV NODE=production
# PORT Is just documentation
ENV PORT=80

WORKDIR /usr/src
COPY --from=builder /usr/src .
# Expose the port that the application listens on.
EXPOSE ${PORT}

# Run the application as a non-root user.
# USER node

# Run the application.
CMD ["node", "index.js"]

# Health Checks explicitly disabled in Kubernetes 1.8
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -fs http://localhost:$PORT || exit 1

