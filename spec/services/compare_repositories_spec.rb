require 'spec_helper'

RSpec.describe CompareRepositories do
  let(:github_information_1) do
    {
      name: 'name1',
      description: 'description 1',
      homepage: 'http://homepage.com',
      language: 'Ruby',
      created_at: 1.day.ago,
      pushed_at: Time.now,
      stargazers_count: 1,
      subscribers_count: 1,
      forks_count: 1,
      open_issues_count: 1
    }
  end
  let(:github_information_2) do
    {
      name: 'name2',
      description: 'description 2',
      homepage: 'http://homepage2.com',
      language: 'Ruby',
      created_at: 2.day.ago,
      pushed_at: Time.now,
      stargazers_count: 2,
      subscribers_count: 2,
      forks_count: 2,
      open_issues_count: 2
    }
  end

  describe '#call' do
    subject { described_class.new(owner1: 'owner', name1: 'name1', owner2: 'owner', name2: 'name2') }

    context 'when exists repository' do
      before do
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name1').and_return(github_information_1)
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name2').and_return(github_information_2)
      end

      it 'persist comparison' do
        expect(PersistComparisonWorker).to receive(:perform_async).with('owner', 'name1', 'owner', 'name2')

        subject.call
      end

      it 'attributes for repository 1' do
        repositories = subject.call

        expect(repositories[0].owner).to eq 'owner'
        expect(repositories[0].name).to eq 'name1'

        github_information_1.each_pair do |key, value|
          expect(repositories[0].information.public_send(key)).to eq value
        end
      end

      it 'attributes for repository 2' do
        repositories = subject.call

        expect(repositories[1].owner).to eq 'owner'
        expect(repositories[1].name).to eq 'name2'

        github_information_2.each_pair do |key, value|
          expect(repositories[1].information.public_send(key)).to eq value
        end
      end
    end

    it 'when does not exists repository' do
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name1').and_raise(Octokit::NotFound)
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name2').and_raise(Octokit::NotFound)

      expect(PersistComparisonWorker).to_not receive(:perform_async)

      expect(subject.call).to match_array [nil, nil]
    end
  end
end
