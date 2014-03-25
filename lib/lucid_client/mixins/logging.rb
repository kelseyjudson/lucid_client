module LucidClient::Logging

  def self.included( base )
    base.extend( self )
  end

  LOGGER = LucidClient::Logger.new( STDOUT )

  def log( msg, type = :info, key = log_key )
    c   = type_colour( type )
    msg = "\e[3#{c}m<#{timestamp} #{key}> \e[1m#{msg}\e[0m"

    LOGGER.send( type, msg )
  end

  def log_error( msg )
    log( msg, :error, "#{log_key} Error" )
  end

  private

  def log_key
    'LucidClient'
  end

  def timestamp
    Time.now.strftime( '%Y%m%d%H%M%S' )
  end

  def type_colour( type )
    colours[type] || 3
  end

  def colours
    { :info => 3, :error => 1 }
  end

end
