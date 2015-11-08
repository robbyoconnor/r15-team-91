class RepositoryInformation
  include Virtus.model

  attribute :owner,             Hash[Symbol => String]
  attribute :name,              String
  attribute :description,       String
  attribute :homepage,          String
  attribute :language,          String
  attribute :created_at,        DateTime
  attribute :pushed_at,         DateTime
  attribute :stargazers_count,  Integer
  attribute :subscribers_count, Integer
  attribute :forks_count,       Integer
  attribute :open_issues_count, Integer

  def owner_avatar_url
    owner[:avatar_url]
  end

  def self.dump(information)
    information.to_hash
  end

  def self.load(information)
    new(information)
  end
end
