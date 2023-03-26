FROM node:15.0.1
FROM ruby:3.0.2

RUN mkdir /src
WORKDIR /src

COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
    && ln -fs /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx


RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client

COPY Gemfile Gemfile.lock /src/
RUN bundle install

COPY package.json yarn.lock /src/
RUN yarn install