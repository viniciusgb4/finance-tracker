class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symble)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_token],
                                  secret_token: Rails.application.credentials.iex_client[:secret_token],
                                  endpoint: 'https://cloud.iexapis.com/v1')
    begin
      qto = client.quote(ticker_symble)
      new(ticker: ticker_symble.upcase, name:qto.company_name, last_price: qto.latest_price)
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symble)
    where(ticker: ticker_symble).first
  end

end
