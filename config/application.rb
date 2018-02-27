require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MovieReviewApi
  class Application < Rails::Application
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.routing_specs false
      generate.helper_specs false
      generate.controller_specs false
      generate.view_specs false
    end
    config.load_defaults 5.1
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :delete],
                      expose: %w(access-token, expiry, token-type, uid, client)
      end
    end
  end
end
