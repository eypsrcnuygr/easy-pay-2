class User < ApplicationRecord
  has_many :transactions, dependent: :destroy, foreign_key: :author_id
  has_many :groups, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }
  has_secure_password

  def name=(value)
    super(value.try(:strip))
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, id: User.last.id + 1, password_digest: '12345678')
      .or(where(name: auth['info']['nickname'][0..19])).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.id = auth['uid']
      user.name = auth['info']['nickname'][0..19]
      user.password_digest = '12345678'
    end
  end
end
