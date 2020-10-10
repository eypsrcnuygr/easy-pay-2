class Group < ApplicationRecord
  belongs_to :user
  has_many :group_transactions, dependent: :destroy
  has_many :transactions, through: :group_transactions, source: :owner
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
end
