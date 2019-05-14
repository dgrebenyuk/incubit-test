## Installation

Clone this repo:

    $ git clone git@github.com:dgrebenyuk/incubit-test.git

Then execute:

    $ bundle install

Create local DB config

    $ cd ./incubit-test/config
    $ cp database.yml.example database.yml

Edit `database.yml` file to fit you local settings.

Create databases and run migrations

    $ rails db:create
    $ rails db:migrate

Start server

    $ rails s

## RSpec

Current functionality is covered by rspec tests.

    $ bundle
    $ rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dgrebenyuk/incubit-test.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
