class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :groups, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }
  has_secure_password
end
