class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"

  has_many :notifications , dependent: :destroy
end
