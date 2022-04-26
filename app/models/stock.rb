class Stock < ApplicationRecord

  def self.new_lookup(ticker_symble)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_token],
                                  secret_token: Rails.application.credentials.iex_client[:secret_token],
                                  endpoint: 'https://cloud.iexapis.com/v1')
    begin
      qto = client.quote(ticker_symble)
      new(ticker: ticker_symble, name:qto.company_name, last_price: qto.latest_price)
    rescue => exception
      return nil
    end
  end

end
