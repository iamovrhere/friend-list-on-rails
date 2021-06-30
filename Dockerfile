# From: https://docs.docker.com/samples/rails/
FROM ruby:2.7 AS base

ARG TARGET_APP='app'
ARG TARGET_DIR='.'

RUN curl -sL https://deb.nodesource.com/setup_14.x > /tmp/setup_node.sh && \
  # Validate node repo setup script.
  sha256sum /tmp/setup_node.sh | grep 597d9b16bca9b8061f23b34933b522267d18f5dff75de3c09a1fad2709f69f16 && \
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
