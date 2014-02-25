module LucidClient::Middleware
  class CallLogger < Base

    def call( env )
      log_request( env )

      app.call( env ).on_complete do |env|
        log_response( env )
      end
    end

    private

    def log_request( env )
      method, uri = env[:method].to_s.upcase, env[:url].to_s

      log "\e[36m%s \e[37m%s" % [ method, uri ]
    end

    def log_response( env )
      log "Response #{env[:status]}"
    end

  end
end
