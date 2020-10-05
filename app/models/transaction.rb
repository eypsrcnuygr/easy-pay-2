class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :group_transactions, dependent: :destroy
  has_many :groups, through: :group_transactions
  accepts_nested_attributes_for :groups

end
