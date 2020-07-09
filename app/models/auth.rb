class Auth < ApplicationRecord
  belongs_to :author
  
  validates :code, presence: true
end
