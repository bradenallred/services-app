class Review < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :rating, inclusion: { in: 1..5 }
  validates :content, presence: true
end
