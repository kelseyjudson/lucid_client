module LucidClient::Middleware
  class Base < Struct.new( :app )

    include LucidClient::Logging

    # Subclasses override.
    #
    def call( env )
      @app.call( env )
    end

  end
end
