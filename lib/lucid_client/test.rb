files = %w{ model_assertions model_interface connection }

files.each do |f|
  require File.expand_path( "../test/#{f}", __FILE__ )
end

module LucidClient
  module Test

    # ...

  end
end
