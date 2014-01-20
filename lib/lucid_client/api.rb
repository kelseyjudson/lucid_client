module LucidClient::API

  def initialize( session )
    @session = session
  end

  private

  def session
    if @session
      @session
    else
      raise 'Decorators must assign @session'
    end
  end

end
