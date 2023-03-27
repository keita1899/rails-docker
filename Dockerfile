FROM node:12 as node
FROM ruby:3.0.2

WORKDIR /src

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client

COPY Gemfile Gemfile.lock /src/
RUN bundle install

COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -fs /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx

COPY package.json yarn.lock /src/
RUN npm install --global yarn
RUN yarn install