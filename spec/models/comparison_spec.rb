require 'rails_helper'

RSpec.describe Comparison do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }

  context 'minimum of repositories' do
    it 'without repository' do
      subject = described_class.new
      subject.valid?
      expect(subject.errors.full_messages).to include 'It is necessary two repositories for make a comparison'
    end

    it 'only one repository' do
      subject = described_class.new repositories: build_list(:repository, 1)
      subject.valid?
      expect(subject.errors.full_messages).to include 'It is necessary two repositories for make a comparison'
    end

    it 'with two repositories' do
      subject = described_class.new repositories: build_list(:repository, 2)
      subject.valid?
      expect(subject.errors.full_messages).to_not include 'It is necessary two repositories for make a comparison'
    end

    it 'many repositories' do
      subject = described_class.new repositories: build_list(:repository, 3)
      subject.valid?
      expect(subject.errors.full_messages).to include 'It is necessary two repositories for make a comparison'
    end
  end

  #
  # associations
  #
  it { is_expected.to have_and_belong_to_many(:repositories) }
end
