FROM ruby:2.3.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
RUN mkdir /prometheus
RUN ls
WORKDIR /myapp
COPY . /myapp
RUN mv prometheus /prometheus
RUN bundle install
