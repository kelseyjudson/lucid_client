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

  def represent( model, resource )
    LucidClient::Resource.new( resource ).as( model )
  end

  def represent_each( model, resources )
    LucidClient::Resource.map( model, resources )
  end

  # In most casts, override with +super.merge( ... )+.
  #
  def _default_params
    { :fields => _fields }
  end

  # A +nil+ for +fields+ returns all fields.
  #
  def _fields
  end

  def session
    if @session
      @session
    else
      raise 'Decorators must assign @session'
    end
  end

end
