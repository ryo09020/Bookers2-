class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates_uniqueness_of :book, scope: :user
end
