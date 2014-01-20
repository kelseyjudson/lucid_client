class LucidClient::LoggingPolicy

  def log?
    !( defined?( ::Rails ) && ::Rails.env.test? )
  end

end
