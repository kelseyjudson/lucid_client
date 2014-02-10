lucid_client
============

`lucid_client` aims to provide a reasonable foundation for building interfaces
to RESTful APIs which are both consistent and extensible while leaving the
details (such as authentication) of each specific implementation up to the
developer.


### Concepts & Basic Usage

By default `lucid_client` includes no direct interfaces to any APIs. A
subclass of `LucidClient::Session` provides the connection to a remote API,
and an implementation of `LucidClient::API` provides the interface to API
methods.

An example use case with the Shopify Billing API may look something like this:

    Shopify::BillingAPI.new( session ).subscribe( shop )

`lucid_client` encourages you to create self contained, specialized interfaces
where you implement only what you need. For example, if you only need access
to Heroku's Domain API, you'd create an interface like:

    class Heroku::DomainAPI < LucidClient::API
      ...

Later on, you may find that you also need access to Dynos, so you create
another, separate interface:

    class Heroku::DynoAPI < LucidClient::API
      ...


### Extras

`lucid_client` provides ANSI highlighted logging with `LucidClient::Logging`
and trivializes mapping resources to local models/objects with
`LucidClient::Model` and `LucidClient::Resource`.

`LucidClient::Env` is a handy interface to environment variables which can
(should?) be used to reference sensitive data such as secret tokens:

    LucidClient.config[:env_prefix] = 'MY_APP'
    LucidClient.client_env( :api_key )

    # => (value of ENV['MY_APP_API_KEY'])

`LucidAsync::Mixin` provides convenient methods for asynchronous requests, but
is especially useful when dealing with ActiveRecord persistence (where
incorrect use of threading can block the connection pool).

    session.post_async( *args )

    async_each( %i{ apple orange banana } ) do |fruit|
      post ...
    end

The `LucidClient::Middleware::CallLogger` middleware logs ANSI highlighted
API requests and response status.


### Examples

See `lucid_shopify` for an example interface.
