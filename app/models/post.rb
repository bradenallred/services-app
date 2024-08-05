class Post < ApplicationRecord
  CATEGORIES = ['Home Improvement & Repair', 'Cleaning Services', 'Landscaping & Gardening', 'Transportation & Moving', 'Personal Care & Wellness', 'Pet Services', 'Event Services', 'Tutoring & Education', 'Automotive Services', 'Technology & Electronics']

  validates :category, presence: true
  validates :job_title, presence: true
  validates :job_description, presence: true

  belongs_to :user
  has_one_attached :image
end
