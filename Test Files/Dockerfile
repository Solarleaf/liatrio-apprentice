# Node 20 with wildcard
FROM node:20
#Working directory in container
WORKDIR /usr/src/app
# Copies rest of application
COPY . .
#Packages
RUN npm install
# Port
EXPOSE 3000
# Start
CMD [ "node", "app.js"]
