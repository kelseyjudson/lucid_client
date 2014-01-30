module LucidClient::RailsCheck

  def rails?
    defined?( ::Rails )
  end

  def active_record?( model = nil )
    ar = defined?( ::ActiveRecord )

    model && ar ? active_record_model?( model ) : ar
  end

  private

  def active_record_model?( model )
    subclass = model.ancestors.include?( ::ActiveRecord::Base )

    subclass && model.table_exists?
  end

end
