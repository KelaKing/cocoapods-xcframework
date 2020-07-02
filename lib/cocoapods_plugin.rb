# frozen_string_literal: true

require 'cocoapods-xcframework/command'

# Hook
module CocoapodsXCFramework
  Pod::HooksManager.register('cocoapods-xcframework', :post_install) do |context|
    Pod::UI.puts context.sandbox_root
  end
end
