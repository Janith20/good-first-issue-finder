FROM node:16-alpine AS dependencies

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --ignore-scripts

COPY . .

RUN npm run build

FROM node:16-alpine AS production

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production --ignore-scripts

COPY . .

COPY --from=dependencies /usr/src/app/build ./build

EXPOSE 3000

CMD ["node", "build/index.js"]

this has been very useful.
