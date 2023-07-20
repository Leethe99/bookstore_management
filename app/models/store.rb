class Store < ApplicationRecord
    has_many :inventories
  has_many :books, through: :inventories
end
