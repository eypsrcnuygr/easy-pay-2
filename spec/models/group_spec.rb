require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'Sercan', password_digest: 12345678) }
  context 'validation' do
    subject do
      described_class.new(name: 'Music', icon: '<i class="fas fa-music"></i>', user_id: user.id)
    end

    it 'Is valid with requirements' do
      expect(subject).to be_valid
    end

    it 'Is valid without icon' do
      subject.icon = nil
      expect(subject).to be_valid
    end

    it 'Is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Is not valid without user' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end

  # Associations testing
  context 'Association' do
    it 'Has many transactions' do
      u = Group.reflect_on_association(:transactions)
      expect(u.macro).to eq(:has_many)
    end

    it 'belongs to user' do
      u = Group.reflect_on_association(:user)
      expect(u.macro).to eq(:belongs_to)
    end
  end
end
