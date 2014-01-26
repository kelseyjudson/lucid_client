module LucidClient::Testing
  class Connection

    class << self

      attr_reader :stubs

      # Build a new connection based on the assigned stubs.
      #
      def build
        ::Faraday.new do |f|
          f.adapter( :test ) { |api| assign_stubs( api ) }
        end
      end

      # This might be used to assign stubs to connection adapters outside of
      # this class.
      #
      def assign_stubs( api )
        @stubs.each do |s|
          method, status, path, response_body = s

          api.send( method, path ) { [ status, {}, response_body ] }
        end
      end

      def stub( s )
        ( @stubs ||= [] ) << s
      end

      def reset_stubs
        @stubs = []
      end

      # Subclasses can set stubs in or outside of their class definition by
      # calling these singleton methods. For example ...
      #
      #     get '/admin/products.json' do
      #       File.read( 'api/responses/products.json' )
      #     end
      #
      %i{ get post patch put delete }.each do |sym|
        define_method( sym ) do |path, status = 200, &block|
          stub( [ sym, status, path, block.call.to_s ] )
        end
      end

      # Given a tree structure of request paths under methods, eg.
      #
      #     root_path/post/admin/products.201.json
      #     root_path/get/admin/products.json
      #
      # ... would stub POST '/admin/products.json' to respond with a status
      # of 201 and the file contents and GET '/admin/products.json' with a
      # status of 200 (default) and the file contents.
      #
      def stub_json_tree( root_path )
        root_path = Pathname.new( root_path )

        %w{ get post patch put delete }.each do |method|
          Dir.glob( root_path.join method, '**/*.json' ).each do |path|
            stub_json_file( method, path )
          end
        end
      end

      # Designed for use with +#stub_json_tree+ ... not recommended to use
      # separately.
      #
      def stub_json_file( method, path, status = 200 )
        request_path = path.split( "/#{method}" ).last

        request_path.sub!( /\.(\d{3})\.json\z/ ) do
          status = $1.to_i; '.json'
        end

        send( method, request_path, status ) do
          File.read( path )
        end
      end

    end

  end
end
