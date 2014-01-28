module LucidClient::RailsCheck

  def rails?
    defined?( ::Rails )
  end

  def active_record?( model = nil )
    ar = defined?( ::ActiveRecord )

    model && ar ? model.ancestors.include?( ::ActiveRecord::Base ) : ar
  end

end
