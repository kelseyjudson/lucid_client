lucid_client
============

`lucid_client` aims to provide interfaces to RESTful APIs which are both
consistent and extensible, and work in most cases with little configuration.

By default it includes no direct interfaces to any APIs. Interfaces require
a subclass of `LucidClient::Session` which provides the connection to a remote
API, and are implemented as classes including `LucidClient::API`.

An example use case with the Shopify Billing API may look something like:

    BillingAPI.new( session ).subscribe( shop )

A reference to `session` would likely be found in the `current_shop` model,
and so making the API call might in fact look like:

    current_shop.api.billing.subscribe

`lucid_client` provides logging highlighted logging with `LucidClient::Logging`
and allows mapping resources to local models/objects with `LucidClient::Model`
and `LucidClient::Resource`.

See `lucid_shopify` for an example interface.
