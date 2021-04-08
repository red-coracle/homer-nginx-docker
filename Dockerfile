FROM node:lts-alpine as build-stage

WORKDIR /app

RUN apk update \
    && apk add --no-cache git \
    && git clone https://github.com/bastienwirtz/homer.git . \
    && yarn install --frozen-lockfile \
    && yarn build \
    && apk del git

FROM nginx:alpine
RUN sed -i 's/worker_processes  auto/worker_processes 1/' /etc/nginx/nginx.conf

COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY --from=build-stage /app/dist/assets /usr/share/nginx/html/default-assets
COPY entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
