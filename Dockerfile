FROM ruby:2.6.0

RUN mkdir /site
WORKDIR /site
VOLUME /site

RUN gem install bundler jekyll
ADD Gemfile /site
ADD Gemfile.lock /site
RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--host", "0.0.0.0"]
