class CompareRepositories
  attr_reader :comparison, :repositories

  def initialize(params)
    @owner1 = params[:owner1]
    @name1  = params[:name1]
    @owner2 = params[:owner2]
    @name2  = params[:name2]
  end

  def call
    load_repositories
    persist_comparison

    repositories
  end

  def self.call(args)
    new(args).call
  end

  private

  attr_reader :owner1, :name1, :owner2, :name2

  def persist_comparison
    if repositories.compact.count == 2
      PersistComparisonWorker.perform_async(owner1, name1, owner2, name2)
    end
  end

  def load_repositories
    @repositories = (1..2).map do |number|
      owner = send("owner#{number}")
      name  = send("name#{number}")

      Rails.cache.fetch([:repository, owner, name]) do
        repository(owner, name)
      end
    end
  end

  def repository(owner, name)
    information = github_information(owner, name)
    return nil if information.blank?

    Repository.new({
      owner: owner,
      name: name,
      information: RepositoryInformation.new(information)
    })
  end

  def github_information(owner, name)
    Octokit.repository(owner: owner, name: name)
  rescue Octokit::NotFound => e
    nil
  end
end
