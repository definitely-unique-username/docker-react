# AWS Beanstalk doesn't support named builders
# FROM node:16-alpine AS builder
FROM node:16-alpine
# USER node
# WORKDIR /home/node/app
WORKDIR /app
# COPY --chown=node:node package.json .
COPY package.json .
RUN npm install
# COPY --chown=node:node . .
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# COPY --from=builder /home/node/app/build /usr/share/nginx/html
# COPY --from=0 /home/node/app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html