# FROM alpine:latest
FROM arm64v8/node:16-alpine AS builder
WORKDIR /my-app-2
COPY /my-app-2/package*.json ./

RUN apk add npm

RUN npm install 

COPY ./my-app-2 .

RUN npm run build

# EXPOSE 3000

# ENTRYPOINT ["npm"]
# CMD ["run", "start"]
FROM arm64v8/nginx:alpine
WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /my-app-2/build .

EXPOSE 4000
ENTRYPOINT ["nginx", "-g", "daemon off;"]

