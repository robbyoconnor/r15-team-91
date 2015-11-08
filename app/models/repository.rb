class Repository < ActiveRecord::Base
  #
  # attributes
  #
  ATTRIBUTES = %i(description created_at pushed_at homepage
                  language stargazers_count forks_count open_issues_count
                  network_count subscribers_count watchers_count)

  attr_accessor *ATTRIBUTES

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
