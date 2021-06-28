# From: https://docs.docker.com/samples/rails/
FROM ruby:2.7

ARG TARGET_APP='app'
ARG TARGET_DIR='.'
RUN curl -sL https://deb.nodesource.com/setup_12.x > /tmp/setup_node.sh && \
  # Valid node repo setup is valid.
  sha256sum /tmp/setup_node.sh | grep 1033ef117045ac81fa2650a336dd6c556ddc623f51587eb34dc621bb31afd67e && \
  echo "sha matches!" && bash /tmp/setup_node.sh \
  apt-get update -qq && \
  apt-get install -y nodejs postgresql-client && \
  gem install rails && \
  npm install --global yarn

WORKDIR /$TARGET_APP

COPY $TARGET_DIR/ /$TARGET_APP/
# When bootstrapping from fresh, this will fail.
RUN bundle install || true

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# Disabling entry point for development purposes.
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# If this were a production image, this would be the
# main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]
