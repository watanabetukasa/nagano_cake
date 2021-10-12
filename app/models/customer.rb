class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  has_many :addresses

  has_many :cart_items

  #退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
