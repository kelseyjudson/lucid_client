module LucidClient::Logging

  LOGGER = LucidClient::Logger.new( STDOUT )

  def log( msg, type = :info, key = log_key )
    c = type_colour( type )

    LOGGER.send( type, "  \e[1;3#{c}m#{key}: #{msg}\e[0m" )
  end

  def log_error( msg )
    log( msg, :error, "#{log_key} Error" )
  end

  private

  def log_key
    'LucidClient'
  end

  def type_colour( type )
    colours[type] || 3
  end

  def colours
    { :info => 3, :error => 1 }
  end

end
