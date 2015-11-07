class Comparison < ActiveRecord::Base
  #
  # associations
  #
  has_and_belongs_to_many :repositories

  #
  # validations
  #
  validates :code, presence: true, uniqueness: true
end
