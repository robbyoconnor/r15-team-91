class CompareController < ApplicationController
  def new
  end

  def show
    repositories = (1..2).map do |number|
      owner = params["owner#{number}"]
      name  = params["name#{number}"]

      return if owner.blank? || name.blank?

      Rails.cache.fetch([:repository, owner, name]) do
        Repository.find_by(owner: owner, name: name)
      end
    end

    @repo1, @repo2 = repositories
  end
end
