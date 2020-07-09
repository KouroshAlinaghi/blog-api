class Author < ApplicationRecord
  has_many :auths, dependent: :destroy
  has_secure_password

  validates :email, presence: true
  validates :full_name, presence: true
end
