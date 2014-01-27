module LucidClient::Model

  def self.included( base )
    base.extend( ClassMethods )
  end

  module ClassMethods

    # Maps local attributes to properties of a remote resource. The block
    # passed to this method is expected to return a hash of mappings.
    #
    # Accessor methods for each local attribute will be created, so call this
    # before defining any accessor overrides.
    #
    def map_resources( &block )
      unless ( mappings = block.call ).kind_of?( Hash )
        raise 'Block in #map_resources must return a Hash'
      end

      attr_unless_exists mappings.keys

      define_singleton_method( :resource_mappings ) do
        mappings
      end
    end

    # A hash of mappings between model attributes and API resource hash values.
    #
    def resource_mappings
      raise NotImplementedError, 'Implement the LucidClient::Model interface'
    end

    def fields
      resource_mappings.values.join( ',' )
    end

    private

    def attr_unless_exists( keys )
      new_keys = no_matching_methods( keys )
      new_keys = no_matching_columns( new_keys ) if defined?( ::ActiveRecord )

      attr_accessor *new_keys
    end

    def no_matching_columns( keys )
      if ancestors.include?( ::ActiveRecord::Base )
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
