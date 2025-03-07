# This version of Linux has Node already installed
ARG NODE_VERSION=16.20.2
FROM node:${NODE_VERSION}-alpine

# Labels
LABEL version=0.1
LABEL description="Testing things out"
LABEL maintainer="L"

# Environmental Varaibles
ENV NODE=production
ENV PORT=80

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


# Old version
# #Cloning git file to folder
# RUN git clone --depth=1 https://github.com/Solarleaf/liatrio-apprentice.git
# WORKDIR /usr/src/liatrio-apprentice
# # Dependency install
# RUN --mount=type=bind,source=package.json,target=package.json \
#     --mount=type=bind,source=package-lock.json,target=package-lock.json \
#     --mount=type=cache,target=/root/.npm \
#     npm ci --omit=dev

# Expose the port that the application listens on.
EXPOSE ${PORT}

# Run the application as a non-root user.
USER node

# Run the application.
CMD ["node", "index.js"]

# Health Check.
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -fs http://localhost:$PORT || exit 1

