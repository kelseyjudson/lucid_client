module LucidClient

  # Maps an API resource hash (from +#get_resource+ or equivalent) to a model
  # which implements the +LucidClient::Model+ interface.
  #
  #     class Product
  #
  #       include LucidClient::Model
  #
  #       def self.resource_mappings
  #         { :product_id => 'id',
  #           :handle     => 'handle',
  #           :name       => 'title',
  #           ...
  #         }
  #       end
  #
  #     end
  #
  #     LucidClient::Resource.new( resource ).as( Product )
  #
  class Resource

    attr_reader :hash

    def initialize( hash )
      @hash = hash
    end

    def self.map( model, resources )
      resources.map do |resource|
        new( resource ).as( model )
      end
    end

    def as( model )
      mappings = model.resource_mappings
      record   = find_or_initialize( model, mappings )

      record.tap do |m|
        mappings.each { |k, v| m.send( "#{k}=", hash[v] ) }
      end
    end

    private

    # If the remote resource includes an ID, attempt to source the record from
    # the local database, else initialize it.
    #
    def find_or_initialize( model, mappings )
      index = mappings.select { |k, v| v == 'id' }.keys.first

      if _active_record?( model ) && index
        model.where( index => hash['id'] ).first_or_initialize
      else
        model.new
      end
    end

    def _active_record?( model )
      if defined?( ::ActiveRecord )
        model.ancestors.include?( ::ActiveRecord::Base )
      end
    end

  end

end
