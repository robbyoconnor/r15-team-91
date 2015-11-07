require 'rails_helper'

RSpec.describe Comparison do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }

  #
  # associations
  #
  it { is_expected.to have_and_belong_to_many(:repositories) }
end
