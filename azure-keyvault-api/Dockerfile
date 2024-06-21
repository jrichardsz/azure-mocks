FROM node:20

ENV NODE_ENV "production"
ENV NODE_OPTIONS --openssl-legacy-provider
EXPOSE 2104

RUN mkdir /app
WORKDIR /app

COPY . /app
RUN npm install

CMD ["npm","run","start"]