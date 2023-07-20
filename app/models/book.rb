class Book < ApplicationRecord
    has_many :inventories
    has_many :stores, through: :inventories
end
