class CompareController < ApplicationController
  def new
  end

  def show
    @repo1, @repo2 = CompareRepositories.call(params)
  end
end
