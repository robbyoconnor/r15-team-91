class Comparison < ActiveRecord::Base
  #
  # associations
  #
  has_and_belongs_to_many :repositories

  #
  # validations
  #
  validates :code, presence: true, uniqueness: true
  validate :need_twice_repositories

  private

  def need_twice_repositories
    if repositories.size != 2
      errors.add(:base, 'It is necessary two repositories for make a comparison') # TODO: Locale?
    end
  end
end
