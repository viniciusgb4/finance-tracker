class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

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

  def full_name
    first_name || last_name ? "#{first_name} #{last_name}" : 'Anonymous'
  end

  def friend_already_followed?(friend_id)
    friends.where(id: friend_id).exists?
  end

  def under_friendship_limit?
    friends.count < 10
  end

  def friend_is_equal_current_user?(friend_id)
    self.id == friend_id
  end

  def can_follow_friend?(friend_id)
    under_friendship_limit? and not friend_already_followed?(friend_id) and not friend_is_equal_current_user?(friend_id)
  end

end
