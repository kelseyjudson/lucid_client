module LucidClient::Test
  module ModelAssertions

    def assert_attributes( attributes )
      attributes.each do |attr|
        assert_respond_to subject, attr
      end
    end

  end
end
