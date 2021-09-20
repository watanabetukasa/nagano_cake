class Item < ApplicationRecord

  has_many :order_details, dependent: :destroy
end
