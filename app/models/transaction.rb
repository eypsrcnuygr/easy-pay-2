class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_transactions, dependent: :destroy
  has_many :groups, through: :group_transactions
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :amount, presence: true
  accepts_nested_attributes_for :groups
end
