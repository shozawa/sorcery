require 'sorcery'
require 'rails'

module Sorcery
  # The Sorcery engine takes care of extending ActiveRecord (if used) and ActionController,
  # With the plugin logic.
  class Engine < Rails::Engine
    config.sorcery = ::Sorcery::Controller::Config

    initializer 'extend Controller with sorcery' do |app|
      if app.config.api_only
        ActionController::API.send(:include, Sorcery::Controller)
        ActionController::API.send(:include, ActionController::Cookies)
        app.config.middleware.use ActionDispatch::Cookies
      else
        ActionController::Base.send(:include, Sorcery::Controller)
        ActionController::Base.helper_method :current_user
        ActionController::Base.helper_method :logged_in?
      end
    end
  end
end
