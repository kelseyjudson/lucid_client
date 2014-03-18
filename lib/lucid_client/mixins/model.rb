module LucidClient::Model

  def self.included( base )
    base.extend( ClassMethods )
    base.resource_mappings = {}
  end

  module ClassMethods

    # Maps local attributes to properties of a remote resource. The block
    # passed to this method is expected to return a hash of mappings.
    #
    # Accessor methods for each local attribute will be created, so call this
    # before defining any accessor overrides.
    #
    def map_properties( hash = {}, options = {}, &block )
      mappings = block_given? ? block.call : hash

      set_properties mappings, options
    end

    # Array of direct mappings to properties of a remote resource, where the
    # local attribute name matches the remote property.
    #
    def api_properties( properties, options = {} )
      mappings = properties.each_with_object( {} ) do |e, h|
        h.merge!( e => e.to_s )
      end

      set_properties mappings, options
    end

    def set_properties( mappings, options )
      attr_unless_exists mappings.keys unless options[:accessors] == false

      resource_mappings.merge!( mappings ) 
    end

    # A hash of mappings between model attributes and API resource hash values.
    #
    attr_accessor :resource_mappings

    def fields
      resource_mappings.values.join( ',' )
    end

    private

    def attr_unless_exists( keys )
      new_keys = no_matching_methods( keys )
      new_keys = no_matching_columns( new_keys )

      attr_accessor *new_keys
    end

    def no_matching_columns( keys )
      if LucidClient::Rails.ar?( self )
        keys.select { |key| !( column_names.include? key.to_s ) }
      else
        keys
      end
    end

    def no_matching_methods( keys )
      keys.select do |key|
        !( instance_methods.include? "#{key}=" )
      end
    end

  end

end
