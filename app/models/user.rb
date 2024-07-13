class User < ApplicationRecord
  enum role: { buyer: 0, business: 1 }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :account_type, presence: true, inclusion: { in: %w[business buyer] }

  has_many :posts, dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "user_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"
end
