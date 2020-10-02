class Group < ApplicationRecord
  belongs_to :user
  has_many :group_transactions, dependent: :destroy
  has_many :transactions, through: :group_transactions, source: :owner
end
