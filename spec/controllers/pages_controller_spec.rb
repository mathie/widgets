require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET index' do
    def do_get
      get :index
    end

    it 'returns http success' do
      do_get

      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      do_get

      expect(response).to render_template('pages/index')
    end
  end
end