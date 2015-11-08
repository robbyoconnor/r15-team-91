class CompareController < ApplicationController
  def new
  end

  def show
    @repo1, @repo2 = CompareRepositories.call(params)
  end

  def create
    redirect_to compare_path(*params[:repo1].split('/'), *params[:repo2].split('/'))
  end
end
