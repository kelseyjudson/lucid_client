module LucidClient; end

require 'lucid_client/mixins/env'

LucidClient.extend( LucidClient::Env )

require 'lucid_client/logger'
require 'lucid_client/logging_policy'

require 'lucid_client/session'
require 'lucid_client/api'
require 'lucid_client/resource'

### Mixins

require 'lucid_client/mixins/asynchronous'
require 'lucid_client/mixins/logging'
require 'lucid_client/mixins/model'

### Middleware

require 'lucid_client/middleware/call_logger'

### Testing

require 'lucid_client/testing/connection'
