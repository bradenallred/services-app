class Post < ApplicationRecord
  CATEGORIES = ['Home Improvement & Repair', 'Cleaning Services', 'Landscaping & Gardening', 'Transportation & Moving', 'Personal Care & Wellness', 'Pet Services', 'Event Services', 'Tutoring & Education', 'Automotive Services', 'Technology & Electronics']

  validates :job_title, :job_description, :category, presence: true, inclusion: { in: CATEGORIES }

  belongs_to :user
  has_one_attached :image
end
