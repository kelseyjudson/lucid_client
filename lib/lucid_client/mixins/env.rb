module LucidClient::Env

  def config
    @config ||= Hash.new
  end

  # Access environment variables in the same way as +env+, but
  # prefix the key with +config[:env_prefix]+.
  #
  #     LucidClient.config[:env_prefix] = 'BANANA'
  #     LucidClient.client_env( :api_key )
  #
  # ... returns the value of +ENV['BANANA_API_KEY']+.
  #
  def client_env( key )
    parts = [ config[:env_prefix], key ]

    var = parts.inject( [] ) do |a, k|
      k ? a << k.to_s.upcase : a
    end.join( '_' )

    ENV[var]
  end

  # Access environment variables by string/symbol. Accepts lowercase and
  # expects environment variables to be all uppercase.
  #
  def env( key )
    ENV[key.to_s.upcase]
  end

end
