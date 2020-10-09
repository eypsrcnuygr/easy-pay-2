require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    subject do
      described_class.new(name: 'Sercan',
                          password_digest: '12345678')
    end

    it 'Is valid with requirements' do
      expect(subject).to be_valid
    end

    it 'Is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Is not valid without password' do
      subject.password_digest = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Association' do
    it 'Has many transactions' do
      u = User.reflect_on_association(:transactions)
      expect(u.macro).to eq(:has_many)
    end

    it 'Has many groups' do
      u = User.reflect_on_association(:groups)
      expect(u.macro).to eq(:has_many)
    end
  end
end
