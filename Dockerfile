FROM node:lts-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
ADD babel.config.js vue.config.js /app/
ADD public /app/public
ADD src /app/src
RUN npm run build

FROM nginx:stable-alpine
COPY --from=builder /app/dist/favicon.ico /usr/share/nginx/html/favicon.ico
COPY --from=builder /app/dist/index.html /usr/share/nginx/html/index.html
COPY --from=builder /app/dist/css usr/share/nginx/html/css
COPY --from=builder /app/dist/js usr/share/nginx/html/js
