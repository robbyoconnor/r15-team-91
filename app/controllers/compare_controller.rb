class CompareController < ApplicationController
  def new
  end

  # TODO: Improve-me (:
  def show
    @repositories = []

    # TODO: Improve for infinite repos...
    if params[:owner1].present? && params[:name1].present?
      @repositories << Repository.find_by(owner: params[:owner1], name: params[:name1])
    end

    # TODO: Improve for infinite repos...
    if params[:owner2].present? && params[:name2].present?
      @repositories << Repository.find_by(owner: params[:owner2], name: params[:name2])
    end
  end
end
