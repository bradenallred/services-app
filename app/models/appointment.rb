class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :date, presence: true
  validates :time, presence: true
  validates :notes, presence: true
end
