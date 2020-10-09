require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(name: 'Sercan', password_digest: 12345678) }
  context 'validation' do
    subject do
      described_class.new(name: 'Buy some food', amount: 350.08, transaction_status: true, author_id: user.id)
    end

    it 'Is valid with requirements' do
      expect(subject).to be_valid
    end

    it 'Is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Is not valid without amount' do
      subject.amount = nil
      expect(subject).to_not be_valid
    end

    it 'Is not valid without user' do
      subject.author_id = nil
      expect(subject).to_not be_valid
    end

  end

  # Associations testing
  context 'Association' do
    it 'Has many groups' do
      u = Transaction.reflect_on_association(:groups)
      expect(u.macro).to eq(:has_many)
    end

    it 'belongs to user' do
      u = Transaction.reflect_on_association(:author)
      expect(u.macro).to eq(:belongs_to)
    end
  end
end
