[![Build Status](https://travis-ci.org/octopusinvitro/kitepkana.svg?branch=master)](https://travis-ci.org/octopusinvitro/kitepkana)
[![build status](https://gitlab.com/octopusinvitro/kitepkana/badges/master/build.svg)](https://gitlab.com/octopusinvitro/kitepkana/commits/master)


# Readme

This is a Rails app to manage my digital books. I may add my paper books as well.

## How to use this project

This is a Ruby project.
You will need to tell your favourite Ruby version manager to set your local Ruby version to the one specified in the `.ruby-version` file.

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

Ensure that the files in the `bin` directory have the right permissions:

```bash
chmod +x bin/*
```

Run any pending migrations:

```bash
bin/rake db:setup RAILS_ENV=development
```

Set up the initial database structure and content:

```bash
bundle exec rake db:setup
```

Once that's done, start up the application:

```bash
bundle exec rails s
```

The application should be available at [localhost:3000](http://localhost:3000) now.


### To run the tests

Run any pending migrations:

```bash
bin/rake db:migrate RAILS_ENV=test
```

Then run the tests:

```bash
bundle exec rspec
```


### Environment Components

- Ruby 2.5.0
- Rails 5.0.6
- SQLite


## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License
