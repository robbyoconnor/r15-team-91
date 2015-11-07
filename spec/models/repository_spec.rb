require 'spec_helper'

RSpec.describe Repository do
  let(:repository) do
    OpenStruct.new(
      description: 'description',
      created_at: 1.day.ago,
      pushed_at: Time.now,
      homepage: 'http://homepage.com',
      language: 'Ruby',
      stargazers_count: 1,
      forks_count: 1,
      open_issues_count: 1,
      network_count: 1,
      subscribers_count: 1,
      watchers_count: 1)
  end
  subject { described_class.new(repository: repository) }

  #
  # methods
  #
  it { expect(subject.name).to eq repository.name }
  it { expect(subject.description).to eq repository.description }
  it { expect(subject.created_at).to eq repository.created_at }
  it { expect(subject.pushed_at).to eq repository.pushed_at }
  it { expect(subject.homepage).to eq repository.homepage }
  it { expect(subject.language).to eq repository.language }
  it { expect(subject.stargazers_count).to eq repository.stargazers_count }
  it { expect(subject.forks_count).to eq repository.forks_count }
  it { expect(subject.open_issues_count).to eq repository.open_issues_count }
  it { expect(subject.network_count).to eq repository.network_count }
  it { expect(subject.subscribers_count).to eq repository.subscribers_count }
  it { expect(subject.watchers_count).to eq repository.watchers_count }

  describe '.find_by' do
    it 'when exists repository' do
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name').and_return(repository)

      response = described_class.find_by(owner: 'owner', name: 'name')

      expect(response).to be_an_instance_of(described_class)
      expect(response.repository).to eq repository
    end

    it 'when does not exists repository' do
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name').and_raise(Octokit::NotFound)

      expect(described_class.find_by(owner: 'owner', name: 'name')).to be_nil
    end
  end
end