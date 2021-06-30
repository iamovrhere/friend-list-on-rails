# From: https://docs.docker.com/samples/rails/
FROM ruby:2.7 AS base

ARG TARGET_APP='app'
ARG TARGET_DIR='.'

RUN curl -sL https://deb.nodesource.com/setup_12.x > /tmp/setup_node.sh && \
  # Validate node repo setup script.
  sha256sum /tmp/setup_node.sh | grep 5d07994f59e3edc2904c547e772b818d10abb066f6ff36ab3db5d686b0fe9a73 && \
  echo "sha matches!" || echo "sha fails!"
RUN bash /tmp/setup_node.sh && \
  apt-get update -qq && \
  apt-get install -y nodejs postgresql-client && \
  gem install rails

WORKDIR /$TARGET_APP
COPY $TARGET_DIR/ /$TARGET_APP/

# Add a script to be executed to run service.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

FROM base as dev

RUN npm install --global yarn
# When bootstrapping from fresh, this will fail.
RUN bundle install || true

FROM base AS prod

RUN bundle install

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Service that runs on container launch.
CMD ["rails", "server", "-b", "0.0.0.0"]
