require 'rails_helper'

RSpec.describe PersistComparisonWorker do
  let(:owner1) { 'owner1' }
  let(:name1)  { 'name1' }
  let(:owner2) { 'owner2' }
  let(:name2)  { 'name2' }
  let(:comparison_code) { Digest::SHA256.hexdigest(["#{owner1}/#{name1}", "#{owner2}/#{name2}"].sort.join('/or/')) }

  describe '#perform' do
    it 'creates repositories' do
      expect {
        subject.perform(owner1, name1, owner2, name2)
      }.to change(Repository, :count).by(2)
    end

    it 'increment execution counter' do
      comparison = create(:comparison, code: comparison_code)

      expect {
        subject.perform(owner1, name1, owner2, name2)
      }.to change { comparison.reload.executions_count }.by(1)
    end

    it 'does not create a new repository when exists' do
      create(:repository, owner: owner1, name: name1)
      create(:repository, owner: owner2, name: name2)

      expect {
        subject.perform(owner1, name1, owner2, name2)
      }.to_not change(Repository, :count)
    end

    it 'creates comparison' do
      expect {
        subject.perform(owner1, name1, owner2, name2)
      }.to change(Comparison, :count).by(1)
    end

    it 'does not create a new comparison when exists' do
      create(:comparison, code: comparison_code)

      expect {
        subject.perform(owner1, name1, owner2, name2)
      }.to_not change(Comparison, :count)
    end

    context 'creates comparison with code in asc (alphabetic) order' do
      it 'desc' do
        subject.perform(owner1, name1, owner2, name2)

        expect(Comparison.last.code).to eq comparison_code
      end

      it 'asc' do
        subject.perform(owner2, name2, owner1, name1)

        expect(Comparison.last.code).to eq comparison_code
      end
    end
  end
end
