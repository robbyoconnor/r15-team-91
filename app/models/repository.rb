class Repository < ActiveRecord::Base
  #
  # validations
  #
  validates :owner, presence: true
  validates :name,  presence: true, uniqueness: { scope: :owner } # TODO: And case insensitive?
end
