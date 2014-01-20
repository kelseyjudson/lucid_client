require 'logger'

class LucidClient::Logger < ::Logger

  def initialize( output )
    super( output )

    @formatter = formatter
  end

  def add( * )
    super if LucidClient::LoggingPolicy.new.log?
  end

  private

  def formatter
    ->( _, _, _, msg ) { "#{msg}\n" }
  end

end
