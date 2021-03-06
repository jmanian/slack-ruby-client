# frozen_string_literal: true
# This file was auto-generated by lib/tasks/web.rake

module Slack
  module Web
    module Api
      module Endpoints
        module OauthV2
          #
          # Exchanges a temporary OAuth verifier code for an access token.
          #
          # @option options [Object] :code
          #   The code param returned via the OAuth callback.
          # @option options [Object] :client_id
          #   Issued when you created your application.
          # @option options [Object] :client_secret
          #   Issued when you created your application.
          # @option options [Object] :redirect_uri
          #   This must match the originally submitted URI (if one was sent).
          # @see https://api.slack.com/methods/oauth.v2.access
          # @see https://github.com/slack-ruby/slack-api-ref/blob/master/methods/oauth.v2/oauth.v2.access.json
          def oauth_v2_access(options = {})
            throw ArgumentError.new('Required arguments :code missing') if options[:code].nil?
            post('oauth.v2.access', options)
          end
        end
      end
    end
  end
end
