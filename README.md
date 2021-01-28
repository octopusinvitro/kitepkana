[![Build Status](https://travis-ci.org/octopusinvitro/kitepkana.svg?branch=master)](https://travis-ci.org/octopusinvitro/kitepkana)
[![build status](https://gitlab.com/octopusinvitro/kitepkana/badges/master/build.svg)](https://gitlab.com/octopusinvitro/kitepkana/commits/master)
[![Coverage Status](https://coveralls.io/repos/github/octopusinvitro/kitepkana/badge.svg?branch=master)](https://coveralls.io/github/octopusinvitro/kitepkana?branch=master)
[![Dependency status](https://badges.depfu.com/badges/f3ba1a00ad804e9048da678d987fb8e0/overview.svg)](https://depfu.com/github/octopusinvitro/kitepkana?project=Bundler)
[![Maintainability](https://api.codeclimate.com/v1/badges/34e592975d85edc09e3b/maintainability)](https://codeclimate.com/github/octopusinvitro/kitepkana/maintainability)

# Readme

This is a Rails app to manage my digital books. I may add my paper books as well.

## How to use this project

This is a Ruby project.
This is a Ruby project. Tell your Ruby version manager to set your local Ruby version to the one specified in the `Gemfile`.

For example, if you are using [rbenv](https://cbednarski.com/articles/installing-ruby/):

1. Install the right Ruby version:
```bash
rbenv install < VERSION >
rbenv rehash
```
1. Move to the root directory of this project and type:
```bash
rbenv local < VERSION >
ruby -v
```

You will also need to install the `bundler` gem, which will allow you to install the rest of the dependencies listed in the `Gemfile` file of this project.

```bash
gem install bundler
rbenv rehash
```


### To initialise the project

This project uses Sqlite. Be sure you have it installed in your system before installing the gems. If you don't, type:

```bash
sudo apt-get install sqlite3 libsqlite3-dev
```

The install all the gems:

```bash
bundle install
```

Run any pending migrations:

```bash
bundle exec rake db:setup db:migrate RAILS_ENV=development
```

Once that's done, start up the application:

```bash
bundle exec rails server -u webrick
```

The application should be available at [localhost:3000](http://localhost:3000) now.


### To run the tests

Run any pending migrations:

```bash
bundle exec rake db:setup db:migrate RAILS_ENV=test
```

Then run the tests:

```bash
bundle exec rake
```


### Environment Components

- Ruby
- Rails
- SQLite


## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License
