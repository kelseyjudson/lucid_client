module LucidClient::API

  def initialize( session )
    @session = session
  end

  private

  %i{ get post patch put delete }.each do |method|
    define_method( method ) do |*args|
      session.send( method, *args )
    end
  end

  def session
    if @session
      @session
    else
      raise 'Decorators must assign @session'
    end
  end

end
