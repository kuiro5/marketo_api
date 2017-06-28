module Marketo
  # Authentication middleware used if oauth_token and refresh_token are set
  class Middleware::Authentication::Token < Marketo::Middleware::Authentication
    def params
      { grant_type: 'client_credentials',
        client_id: @options[:client_id],
        client_secret: @options[:client_secret] }
    end
  end
end
