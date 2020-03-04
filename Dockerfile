FROM ruby:2.7

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod a+x start.sh

EXPOSE 4567

CMD ./start.sh
