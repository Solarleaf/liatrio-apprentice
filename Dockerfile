# Build Stage

# apprentice-action / action/yaml is using node-version '16' However, 16 is not listed as a supported tag
# node-version also has warnings in GitHub Actions
# ARG NODE_VERSION=16.20.2

# Going with a 20.19.0-alpine.3.20. Earliest listed is 18. No 19.
# To get the docker image docker pull node:20.19.0-alpine3.20
# To get the Sha: docker inspect --format='{{index .RepoDigests 0}}' node:20.19.0-alpine3.20
FROM node:20.19.0-alpine3.20@sha256:9a9c00587bcb88209b164b2dba1f59c7389ac3a2cec2cfe490fc43cd947ed531 AS builder

# Labels
LABEL version=0.1 \
    description="Liatrio API" \
    maintainer="L"

# Checking for updates & adding git and docker
# Cache busting shouldn't be needed given GitHub Actions. && rm -rf /var/cache/apk/* could be added
RUN apk update && apk upgrade --available && apk add git && apk add docker  
#work Directory
WORKDIR /usr/src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
# Using production for now since not using any Dev tools in this area, for now
# RUN npm install --production
# ci is clean install defined by package-lock.json
# CI is generally better for DevOps
RUN npm ci --omit=dev

# Rest of code. Needs to be below dependencies
COPY . .

# Run stage
# Going with a 20.19.0-alpine.3.20
FROM node:20.19.0-alpine3.20@sha256:9a9c00587bcb88209b164b2dba1f59c7389ac3a2cec2cfe490fc43cd947ed531

# Improves performance, reduces memory, disables some debugging
ENV NODE_ENV=production

WORKDIR /usr/src
COPY --from=builder /usr/src .
# Expose the port that the application listens on.
EXPOSE 80

# Run the application as a non-root user could be done
# Kubernetes can overide user settings in securityContext
# USER node

# Run the application.
CMD ["node", "index.js"]

# Health Checks explicitly disabled in Kubernetes 1.8
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -fs http://localhost:$PORT || exit 1


# docker build -t liatrio-app .
# docker run -d --name liatrio-test -p 80:80 liatrio-app

# Powershell
# docker stop liatrio-test; docker rm liatrio-test

# CMD
# docker stop liatrio-test && docker rm liatrio-test