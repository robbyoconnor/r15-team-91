class Repository
  #
  # attributes to list automatically
  #
  ATTRIBUTES = %i(description homepage language created_at pushed_at
                  stargazers_count subscribers_count forks_count open_issues_count)

  attr_accessor :repository

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

  private

  def method_missing(method_sym, *_arguments, &_block)
    return repository[method_sym] if repository.respond_to? method_sym

    super
  end
end
