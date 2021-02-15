FROM madnight/docker-alpine-wkhtmltopdf AS build-wkhtmltopdf

FROM ruby:2.7.2-alpine as build-base

RUN apk add --update --no-cache \
    build-base tzdata nodejs postgresql-dev postgresql-client \
    libxslt-dev libxml2-dev imagemagick yarn git ca-certificates openssh less sqlite-dev

FROM build-base as build-ci

COPY Gemfile* ./
RUN bundle install --jobs 20 --retry 5

RUN yarn install --modules-folder /node_modules/

FROM build-base as build-dev
WORKDIR /app

COPY Gemfile* /app/
RUN bundle install --jobs 20 --retry 5

COPY package.json yarn.lock /app/
RUN yarn install

COPY . /app/

EXPOSE 3000
CMD bundle exec rails s -b 0.0.0.0
