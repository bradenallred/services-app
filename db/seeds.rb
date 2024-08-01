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

# Service names array
service_names = [
  'Car Washing', 'Dog Walking', 'House Cleaning', 'Gardening', 'Personal Training',
  'Tutoring', 'Graphic Design', 'Web Development', 'App Development', 'Photography',
  'Videography', 'Moving Services', 'Laundry Services', 'Catering', 'Event Planning',
  'IT Support', 'Painting Services', 'Plumbing', 'Electrical Services', 'Carpentry',
  'Pest Control', 'Roofing', 'Masonry', 'Interior Design', 'Auto Repair',
  'Pet Sitting', 'Babysitting', 'Elderly Care', 'Massage Therapy', 'Fitness Coaching',
  'Yoga Instruction', 'Language Translation', 'Voice Acting', 'Writing Services', 'Editing Services',
  'Virtual Assistance', 'Social Media Management', 'SEO Services', 'Content Creation', 'Digital Marketing',
  'Tax Preparation', 'Financial Planning', 'Legal Consultation', 'Real Estate Services', 'Mortgage Brokerage',
  'Insurance Brokerage', 'Travel Planning', 'Concierge Services', 'Personal Shopping', 'Tailoring'
]

# Create 50 posts
service_names.each do |service_name|
  Post.create!(
    content: service_name,
    user: test_user
  )
end

puts "Seeded 50 posts for #{test_user.email} with account type #{test_user.account_type}"