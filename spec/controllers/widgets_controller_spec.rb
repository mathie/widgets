require 'rails_helper'

RSpec.describe WidgetsController do
  describe 'GET index' do
    let(:widget_class) { class_spy('Widget').as_stubbed_const }
    let(:widgets) { [instance_spy('Widget')] }

    before(:each) do
      allow(widget_class).to receive(:all) { widgets }
    end

    def do_get
      get :index
    end

    it 'fetches a list of widgets from the model' do
      do_get

      expect(widget_class).to have_received(:all)
    end

    it 'responds with http success' do
      do_get

      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      do_get

      expect(response).to render_template('widgets/index')
    end

    it 'passes the list of widgets to the template' do
      do_get

      expect(assigns(:widgets)).to eq(widgets)
    end
  end
end