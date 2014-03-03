module LucidClient::Test
  module ModelInterface

    include ModelAssertions

    def test_implements_resource_mappings
      assert_kind_of Hash, model_class.resource_mappings
    end

    def test_resource_mappings_map_to_methods
      assert_attributes model_class.resource_mappings.keys
    end

    def test_implements_fields
      assert_respond_to model_class, :fields

      assert_equal model_class.resource_mappings.values.map( &:to_s ),
                   model_class.fields.split( ',' )
    end

    private

    def model_class
      raise 'Model interface tests should define #model_class'
    end

  end
end
