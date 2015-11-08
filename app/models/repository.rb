class Repository
  #
  # attributes to list automatically
  #
  ATTRIBUTES = %i(created_at pushed_at stargazers_count
                  subscribers_count forks_count open_issues_count)

  attr_accessor :repository

  extend Forwardable
  def_delegators :@repository, :name, :owner, :description, :homepage, :language, *ATTRIBUTES

  #
  # methods
  #
  def initialize(repository:)
    @repository = repository
  end

  def self.find_by(owner:, name:)
    new(repository: Octokit.repository(owner: owner, name: name))
  rescue Octokit::NotFound => e
    nil
  end
end
