class Stock < ApplicationRecord

  def self.new_lookup(ticker_symble)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_token],
                                  secret_token: Rails.application.credentials.iex_client[:secret_token],
                                  endpoint: 'https://cloud.iexapis.com/v1')
    qto = client.quote(ticker_symble)
    qto.latest_price
  end

end
