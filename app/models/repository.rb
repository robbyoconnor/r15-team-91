class Repository < ActiveRecord::Base
  #
  # attributes
  #
  attr_accessor :information
  serialize :information, RepositoryInformation

  #
  # validations
  #
  validates :owner, presence: true
  validates :name,  presence: true, uniqueness: { scope: :owner } # TODO: And case insensitive?

  #
  # methods
  #
  def to_s
    "#{owner}/#{name}"
  end
end
