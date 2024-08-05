class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :message

  scope :unread, -> { where(read: false) }
end
