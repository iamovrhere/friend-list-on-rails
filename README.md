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

1. Run `./run.sh` to start containers.
1. Run `./dev.sh` to start interactive session.
1. `entrypoint.sh` (or `rails s`) to serve Ruby.
1. Access at `http://localhost:3000/`.
1. To stop `docker-compose down`.

You may need to run `sudo chown -R $USER:$USER *` to fix permissions if you create files within the container as root.

## Notes

1. `rails s` - Starts rails server.
1. `rails routes` - Display all the routes.
1. `erb` - Embeded Ruby.
1. `rails g controller home index` - Generators creates controller from template. Can be found at `http://localhost:3000/home/index`.
1. Start partials with `_` such as `_header.html.erb` then you can call `<%= render 'home/header' %>`
1. Links work as: `<%= link_to 'About Us', home_about_path, class:"nav-link" %>` where the paths are like your routes/controller; `home/about` -> `home_about` then `_path`. You can get this info from `rails routes`
    ```
    $ rails routes | grep home_about
                              home_about GET    /home/about(.:format)                                                                             home#about
    ```
1. `rails g scaffold friend first_name:string last_name:string email:string phone:string twitter:string`
    * Needs to be singular or will be forced singular.
    * Review: https://guides.rubyonrails.org/v3.2/migrations.html#supported-types
1. `rails db:migrate` - Runs the migrations.
    ```
    == 20210627175159 CreateFriends: migrating ====================================
    -- create_table(:friends)
      -> 0.0055s
    == 20210627175159 CreateFriends: migrated (0.0057s) ===========================
    ```
1. `resources :friends` - Handles a bunch of sub-routes.
1. https://rubygems.org/ - Normally:
  1.  Copy paste into `Gemfile` (`gem 'devise', '~> 4.8'`)
  1. `bundle install` (Need to be root in container)
  1. https://rubygems.org/gems/devise has more steps
  1. `rails g devise:install`
    ```
    Running via Spring preloader in process 369
          create  config/initializers/devise.rb
          create  config/locales/devise.en.yml
    ===============================================================================

    Depending on your application's configuration some manual setup may be required:

      1. Ensure you have defined default url options in your environments files. Here
        is an example of default_url_options appropriate for a development environment
        in config/environments/development.rb:

          config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

        In production, :host should be set to the actual host of your application.

        * Required for all applications. *

      2. Ensure you have defined root_url to *something* in your config/routes.rb.
        For example:

          root to: "home#index"

        * Not required for API-only Applications *

      3. Ensure you have flash messages in app/views/layouts/application.html.erb.
        For example:

          <p class="notice"><%= notice %></p>
          <p class="alert"><%= alert %></p>

        * Not required for API-only Applications *

      4. You can copy Devise views (for customization) to your app by running:

          rails g devise:views

        * Not required *

    ===============================================================================
    ```
    1. `rails g devise:views`
    1. `rails g devise user` + `rails db:migrate`
1. Next?

## Future notes

Since I'm developing in Docker, if I decide to do this again:

To bootstrap without Gemfile, you need to disable some steps in entrypoint/Dockerfile/docker-compose.

Then run `rails new friend-list-on-rails`.

When setting up the database for the first time need to run `rake db:create`.

