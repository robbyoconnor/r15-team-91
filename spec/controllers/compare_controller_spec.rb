RSpec.describe CompareController, type: :controller do
  describe 'POST create' do
    it 'redirects to show' do
      post :create, repo1: 'plataformatec/devise', repo2: 'thoughtbot/clearance'
      show = compare_path('plataformatec', 'devise', 'thoughtbot', 'clearance')
      expect(response).to redirect_to(show)
    end
  end
end
