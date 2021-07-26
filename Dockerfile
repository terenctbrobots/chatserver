#
# Multi-stage docker file which builds/compile a production
# container for deployment
#
FROM node:14-alpine AS builder

WORKDIR /app
COPY package.json ./
COPY tsconfig.json ./
COPY src ./src
RUN ls -a 
RUN npm install
RUN npm run build

#
# 2nd Sstage that copies build javacript files over
# and runs it using pm2 on port 80
FROM node:14-alpine
WORKDIR /app
COPY package.json ./
RUN npm install --only production
COPY --from=builder /app/dist .
RUN npm install pm2 -g
EXPOSE 8080
CMD ["pm2-runtime","server.js"]
