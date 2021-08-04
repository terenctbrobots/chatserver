#
# Multi-stage docker file which builds/compile a production
# container for deployment.
# Build it using: docker build -t chatserver .
# Run it using: docker run -p 8080:8080 -it chatserver
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
# 2nd Stage download the appropriate production ONLY
# packages
FROM node:14-alpine as packager
WORKDIR /app
COPY package.json ./
RUN npm install --only production
#
# 3rd Stage is the final image, installs a distroless image
# and copies all the code and packages from the previous
# two stage. Notes: USER 1000 = node 
FROM gcr.io/distroless/nodejs:14
COPY --from=builder /app/dist .
COPY --from=packager /app .
EXPOSE 8080
USER 1000
CMD ["server.js"]
