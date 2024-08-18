class Post < ApplicationRecord
  CATEGORIES = ['Home Improvement & Repair', 'Cleaning Services', 'Landscaping & Gardening', 'Transportation & Moving', 'Personal Care & Wellness', 'Pet Services', 'Event Services', 'Tutoring & Education', 'Automotive Services', 'Technology & Electronics']

  validates :category, presence: true
  validates :job_title, presence: true
  validates :job_description, presence: true

  belongs_to :user
  has_many_attached :images

  has_many :saved_posts
  has_many :saved_by_users, through: :saved_posts , source: :user

  has_many :reviews, dependent: :destroy

  has_many :appointments
  
  def average_rating
    reviews.average(:rating).to_f.round(2) if reviews.present?
  end
end
