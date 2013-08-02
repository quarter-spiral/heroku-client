# Heroku::Client

A library to use Heroku's [Platform API](https://devcenter.heroku.com/articles/platform-api-reference).

**Currently only retrieving and scaling dynos is supported!**

## Setup a client

Create a client using your Heroku email address and the corresponding [API token](https://dashboard.heroku.com/account#show-api-key).

```ruby
require 'heroku/client'
client = Heroku::Client.new('your-heroku-mail@example.com', 'your-heroku-api-token')
```

## Retrieve the current setup of an app

You can see the number and size of all dyno types (web, worker, etc) via the [formation](https://devcenter.heroku.com/articles/platform-api-reference#formation) of an app.

```ruby
app = client.app('your-app-name')
app.formation
# => {"web"=>{"quantity"=>2, "size"=>"1x"}, "worker"=>{"quantity"=>1, "size"=>"1x"}, "console"=>{"quantity"=>0, "size"=>"1x"}, "rake"=>{"quantity"=>0, "size"=>"1x"}}
```

## Scale dynos of an app

You can scale the number of dynos and change the dyno size of a certain type of process.

```ruby
# scales the web process to 2 dynos of the size 1X
app.scale('web', 2, '1x')
# => {"web"=>{"quantity"=>2, "size"=>"1x"}, "worker"=>{"quantity"=>1, "size"=>"1x"}, "console"=>{"quantity"=>0, "size"=>"1x"}, "rake"=>{"quantity"=>0, "size"=>"1x"}}
```