class Author < ApplicationRecord
  has_secure_password

  has_many :auths, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :email, presence: true
  validates :full_name, presence: true
end
