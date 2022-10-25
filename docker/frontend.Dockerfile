# FROM alpine:latest
FROM arm64v8/node:16-alpine AS builder
WORKDIR /my-app
COPY /my-app/package*.json ./

RUN apk add npm

RUN npm install 

COPY ./my-app .

RUN npm run build

# EXPOSE 3000

# ENTRYPOINT ["npm"]
# CMD ["run", "start"]
FROM arm64v8/nginx:alpine
WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /my-app/build .

EXPOSE 3000
ENTRYPOINT ["nginx", "-g", "daemon off;"]

