FROM node:alpine3.16 as nodework
WORKDIR /myapp
COPY package.json .
RUN npm install
COPY npm run build

#ngnix block
FROM ngnix:1.23-alpine
WORKDIR /usr/share/ngnix/html
RUN rm -rf ./*
COPY --from=nodework /myapp/build .
ENTRYPOINT ["ngnix","-g", "daemon off;"]
