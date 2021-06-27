# Friend List on Rails

The actual app is inside the [`friend-list-on-rails`](./friend-list-on-rails) directory. Based on the video ["Learn Ruby on Rails - Full Course" by  freeCodeCamp.org](https://www.youtube.com/watch?v=fmyvWz5TUWg).

A quick crash course to get me clued into Ruby on Rails before applying to a company I'm interested in.

The docker file + scripts are just a docker compose wrapper so I have a clean environment to work with.

## Installation

### Requirements

Based on https://docs.docker.com/samples/rails/. Requires:

* `docker` (20.10.7)
* `docker-compose` (1.28.0)
* `bash` (4.4.2)

### Setup

1. Run `./run.sh` to start.
1. Run `./dev.sh` to start interactive session.
1. Access at `http://localhost:3000/`.
1. To stop `docker-compose down`.

You may need to run `sudo chown -R $USER:$USER *` to fix permissions if you create files within the container as root.

## Future notes

Since I'm developing in Docker, if I decide to do this again:

To bootstrap without Gemfile, you need to disable some steps in entrypoint/Dockerfile/docker-compose.

Then run `rails new friend-list-on-rails`.

