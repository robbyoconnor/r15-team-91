class PersistComparisonWorker
  include Sidekiq::Worker

  def perform(owner1, name1, owner2, name2)
    @repository1 = Repository.find_or_create_by(owner: owner1, name: name1)
    @repository2 = Repository.find_or_create_by(owner: owner2, name: name2)

    comparison = Comparison.find_or_create_by(code: comparison_code)
    comparison.repositories << @repository1
    comparison.repositories << @repository2
    comparison.increment!(:executions_count)
  end

  private

  attr_reader :repository1, :repository2

  def comparison_code
    Digest::SHA256.hexdigest([@repository1, @repository2].map(&:to_s).sort.join('/or/'))
  end
end
