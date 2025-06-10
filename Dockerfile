# Étape de build
FROM node:16 as build

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

# Étape de production
FROM node:16-alpine

RUN yarn global add serve

WORKDIR /app

COPY --from=build /app/build .

EXPOSE 5000

CMD ["serve", "-s", ".", "-l", "5000"]