require 'spec_helper'

describe MarketoApi::Middleware::Authentication::Token do
  let(:options) do
    {
      instance_url: 'https://login.marketo.com',
      client_id: 'client_id',
      client_secret: 'client_secret',
      adapter: :net_http }
  end

  it_behaves_like 'authentication middleware' do
    let(:success_request) do
      stub_login_request(
        body: "grant_type=client_credentials&" \
                 "client_id=client_id&client_secret=client_secret"
      ).to_return(status: 200, body: fixture(:auth_success_response))
    end

    let(:fail_request) do
      stub_login_request(
        body: "grant_type=client_credentials&" \
                 "client_id=client_id&client_secret=client_secret"
      ).to_return(status: 400, body: fixture(:refresh_error_response))
    end
  end
end
