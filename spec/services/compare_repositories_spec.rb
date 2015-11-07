require 'spec_helper'

RSpec.describe CompareRepositories do
  let(:github_information_1) do
    {
      description: 'description 1',
      created_at: 1.day.ago,
      pushed_at: Time.now,
      homepage: 'http://homepage.com',
      language: 'Ruby',
      stargazers_count: 1,
      forks_count: 1,
      open_issues_count: 1,
      network_count: 1,
      subscribers_count: 1,
      watchers_count: 1
    }
  end
  let(:github_information_2) do
    {
      description: 'description 2',
      created_at: 2.day.ago,
      pushed_at: Time.now,
      homepage: 'http://homepage2.com',
      language: 'Ruby',
      stargazers_count: 2,
      forks_count: 2,
      open_issues_count: 2,
      network_count: 2,
      subscribers_count: 2,
      watchers_count: 2
    }
  end

  describe '#call' do
    subject { described_class.new(owner1: 'owner', name1: 'name1', owner2: 'owner', name2: 'name2') }

    context 'when exists repository' do
      it 'attributes for repository 1' do
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name1').and_return(github_information_1)
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name2').and_return(github_information_2)

        repositories = subject.call

        expect(repositories[0].owner).to eq 'owner'
        expect(repositories[0].name).to eq 'name1'

        Repository::ATTRIBUTES.each do |attr|
          expect(repositories[0].public_send(attr)).to eq github_information_1[attr]
        end
      end

      it 'attributes for repository 2' do
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name1').and_return(github_information_1)
        allow(Octokit).to receive(:repository).with(owner: 'owner', name: 'name2').and_return(github_information_2)

        repositories = subject.call

        expect(repositories[1].owner).to eq 'owner'
        expect(repositories[1].name).to eq 'name2'

        Repository::ATTRIBUTES.each do |attr|
          expect(repositories[1].public_send(attr)).to eq github_information_2[attr]
        end
      end
    end

    it 'when does not exists repository' do
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name1').and_raise(Octokit::NotFound)
      expect(Octokit).to receive(:repository).with(owner: 'owner', name: 'name2').and_raise(Octokit::NotFound)

      expect(subject.call).to match_array [nil, nil]
    end
  end
end
