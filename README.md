lucid_client
============

`lucid_client` aims to provide a reasonable foundation for building interfaces
to RESTful APIs which are both consistent and extensible while leaving the
details (such as authentication) of each specific implementation up to the
developer.

By default it includes no direct interfaces to any APIs. Interfaces require
a subclass of `LucidClient::Session` which provides the connection to a remote
API, and implement the `LucidClient::API`.

An example use case with the Shopify Billing API may look something like:

    BillingAPI.new( session ).subscribe( shop )

`lucid_client` provides highlighted logging with `LucidClient::Logging` and
trivializes mapping resources to local models/objects with `LucidClient::Model`
and `LucidClient::Resource`.

It also provides a handy interface to local environment variables with
`LucidClient::Env` which can be used to reference sensitive data such as
secret tokens:

    LucidClient.config[:env_prefix] = 'MY_APP'
    LucidClient.client_env( :api_key )

    # => (value of ENV['MY_APP_API_KEY'])

See `lucid_shopify` for an example interface.
