module LucidClient::Model

  # A hash of mappings between model attributes and API resource hash values.
  #
  def resource_mappings
    raise NotImplementedError, 'Implement the LucidClient::Model interface'
  end

  def fields
    resource_mappings.values.join( ',' )
  end

end
