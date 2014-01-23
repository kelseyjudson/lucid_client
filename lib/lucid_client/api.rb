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

  ### Resource Mapping

  def represent( resource, model = _model )
    represent_as( resource, model ) do
      LucidClient::Resource.new( resource ).as( model )
    end
  end

  def represent_each( resources, model = _model )
    represent_as( resources, model ) do
      LucidClient::Resource.map( model, resources )
    end
  end

  # Only map to resource is the given model implements +LucidClient::Model+.
  # You might want to set these models as a config setting to avoid hard
  # coding it into your interfaces, eg.
  #
  #     represent_each( LucidClient.config[:shop_model], resources )
  #
  def represent_as( resource, model = _model, &block )
    is_model?( model ) ? block.call( resource ) : resource
  end

  def is_model?( model )
    if model.respond_to?( :ancestors )
      model.ancestors.include?( LucidClient::Model )
    end
  end

  ### Request Parameters

  # In most casts, override with +super.merge( ... )+.
  #
  def _default_params
    { :fields => _fields }
  end

  # A +nil+ for +fields+ returns all fields.
  #
  def _fields
    model_fields
  end

  def model_fields( options = {} )
    model = options[:model] || _model

    is_model?( model ) ? model.fields : options[:default]
  end

  def _model
  end

  def session
    if @session
      @session
    else
      raise 'Decorators must assign @session'
    end
  end

end
