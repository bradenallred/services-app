# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Ensure the test user exists
test_user = User.find_or_create_by!(email: 'testuser@mail.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.account_type = 'business'
end

# Ensure the user account_type is set to 'business' if the user already exists
test_user.update!(account_type: 'business')

# Service names and categories array
services_with_categories = [
  { name: 'Car Washing', category: 'Automotive Services' },
  { name: 'Dog Walking', category: 'Pet Services' },
  { name: 'House Cleaning', category: 'Cleaning Services' },
  { name: 'Gardening', category: 'Landscaping & Gardening' },
  { name: 'Personal Training', category: 'Personal Care & Wellness' },
  { name: 'Tutoring', category: 'Tutoring & Education' },
  { name: 'Graphic Design', category: 'Technology & Electronics' },
  { name: 'Web Development', category: 'Technology & Electronics' },
  { name: 'App Development', category: 'Technology & Electronics' },
  { name: 'Photography', category: 'Event Services' },
  { name: 'Videography', category: 'Event Services' },
  { name: 'Moving Services', category: 'Transportation & Moving' },
  { name: 'Laundry Services', category: 'Cleaning Services' },
  { name: 'Catering', category: 'Event Services' },
  { name: 'Event Planning', category: 'Event Services' },
  { name: 'IT Support', category: 'Technology & Electronics' },
  { name: 'Painting Services', category: 'Home Improvement & Repair' },
  { name: 'Plumbing', category: 'Home Improvement & Repair' },
  { name: 'Electrical Services', category: 'Home Improvement & Repair' },
  { name: 'Carpentry', category: 'Home Improvement & Repair' },
  { name: 'Pest Control', category: 'Home Improvement & Repair' },
  { name: 'Roofing', category: 'Home Improvement & Repair' },
  { name: 'Masonry', category: 'Home Improvement & Repair' },
  { name: 'Interior Design', category: 'Home Improvement & Repair' },
  { name: 'Auto Repair', category: 'Automotive Services' },
  { name: 'Pet Sitting', category: 'Pet Services' },
  { name: 'Babysitting', category: 'Personal Care & Wellness' },
  { name: 'Elderly Care', category: 'Personal Care & Wellness' },
  { name: 'Massage Therapy', category: 'Personal Care & Wellness' },
  { name: 'Fitness Coaching', category: 'Personal Care & Wellness' },
  { name: 'Yoga Instruction', category: 'Personal Care & Wellness' },
  { name: 'Language Translation', category: 'Tutoring & Education' },
  { name: 'Voice Acting', category: 'Event Services' },
  { name: 'Writing Services', category: 'Technology & Electronics' },
  { name: 'Editing Services', category: 'Technology & Electronics' },
  { name: 'Virtual Assistance', category: 'Technology & Electronics' },
  { name: 'Social Media Management', category: 'Technology & Electronics' },
  { name: 'SEO Services', category: 'Technology & Electronics' },
  { name: 'Content Creation', category: 'Technology & Electronics' },
  { name: 'Digital Marketing', category: 'Technology & Electronics' },
  { name: 'Tailoring', category: 'Personal Care & Wellness' }
]

# Create 50 posts with categories
services_with_categories.each do |service|
  Post.create!(
    job_title: service[:name],
    job_description: "Sample Description here",
    category: service[:category],
    user: test_user
  )
end

puts "Seeded 50 posts for #{test_user.email} with account type #{test_user.account_type}"