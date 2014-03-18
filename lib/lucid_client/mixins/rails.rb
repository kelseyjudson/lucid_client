module LucidClient::Rails

  extend self

  def rails?
    ! defined?( ::Rails ).nil?
  end

  def ar?( model = nil )
    ar = ! defined?( ::ActiveRecord ).nil?

    model && ar ? ar_model?( model ) : ar
  end

  private

  def ar_model?( model )
    subclass = model.ancestors.include?( ::ActiveRecord::Base )

    subclass && model.table_exists?
  end

end
