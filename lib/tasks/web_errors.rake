# frozen_string_literal: true
require 'json-schema'
require 'erubis'
require 'active_support'
require 'active_support/core_ext'

namespace :slack do
  namespace :web do
    namespace :api do
      desc 'Update Web API errors'
      task :update_errors do
        spec = JSON.load(open('https://raw.githubusercontent.com/slackapi/slack-api-specs/master/web-api/slack_web_openapi_v2.json'))

        known_typos = %w[account_inactiv token_revokedno_permission]

        errors = spec['paths'].map do |_, path|
          path.map do |_, v|
            v['responses'].map do |_, response|
              response.dig('schema', 'properties', 'error', 'enum')
            end
          end
        end.flatten.compact.uniq

        errors -= known_typos

        error_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/error.erb'))
        errors.each do |error|
          rendered_error = error_template.result(error: error)
          File.write("lib/slack/web/api/errors/#{error}.rb", rendered_error)
        end

        errors_template = Erubis::Eruby.new(File.read('lib/slack/web/api/templates/errors.erb'))
        rendered_errors = errors_template.result(errors: errors)
        File.write("lib/slack/web/api/errors.rb", rendered_errors)
      end
    end
  end
end
