require 'rails_helper'

RSpec.describe Repository do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:owner) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'uniqueness' do
    subject { described_class.new(owner: 'owner') }

    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:owner) }
  end

  #
  # methods
  #
  it '#to_s' do
    expect(subject.to_s).to eq "#{subject.owner}/#{subject.name}"
  end
end
