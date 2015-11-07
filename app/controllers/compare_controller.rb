class CompareController < ApplicationController
  def new
  end

  def show
    @repositories = CompareRepositories.call(params)
  end
end
