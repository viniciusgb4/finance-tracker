class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symble)
    stock = Stock.check_db(ticker_symble)
    return stock ? stocks.where(id: stock.id).exists? : false
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symble)
    under_stock_limit? and not stock_already_tracked?(ticker_symble)
  end

end
