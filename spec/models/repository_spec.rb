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
end
