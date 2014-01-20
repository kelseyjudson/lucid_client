require 'faraday'
require 'excon'

module LucidClient

  # This is an abstract class and should not be instantiated directly. Methods
  # named with a leading underscore are intended (but not required) to be
  # reimplemented by the subclass.
  #
  # Subclasses may define +#_request_path+ if the API interface follows a
  # predictable structure. For example, Shopify:
  #
  #     def _request_path( path )
  #       "/admin/#{path}.json"
  #     end
  #
  class Session

    attr_reader :uri, :connection

    def initialize( options = {} )
      @uri        = options[:uri]        || _default_uri
      @connection = options[:connection] || _default_connection
    end

    ### Generic Requests

    %i{ get post patch put }.each do |method|
      define_method( method ) do |path, *args|
        connection.send method, _request_path( path ), *args
      end
    end

    # Delete requests probably never need to return more than a boolean value
    # representing whether or not the request was successful.
    #
    def delete( path, *a )
      response = connection.delete( _request_path path, *a )

      response.status == 200
    end

    ### Specialized Requests

    # Retrieve a single JSON resource and parse.
    #
    def get_resource( *a )
      response = get *a

      parse_resource( response )
    end

    # POST parameters in JSON format.
    #
    def post_as_json( path, options )
      post( path, options.to_json )
    end

    private

    def _default_connection
      if uri && _headers.any?
        Faraday.new( uri, :headers => _headers ) do |f|
          _middleware.each { |m| f.use m }

          f.adapter :excon
        end
      else
        Faraday
      end
    end

    def _default_uri
    end

    def _headers
      Hash.new
    end

    def _middleware
      Array.new
    end

    def _request_path( path )
      path
    end

    def parse_response( response )
      JSON.parse( response.body )
    end

    # API resources generally take the form +resource_type => resource_hash+.
    # This parses and then strips the key leaving only the resource hash.
    #
    def parse_resource( response )
      parse_response( response.body ).first.last
    end

  end
end
