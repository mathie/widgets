require 'rails_helper'

RSpec.describe WidgetsController do
  let(:widget_class) { class_spy('Widget').as_stubbed_const }

  describe 'GET index' do
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

  describe 'GET new' do
    let(:widget) { instance_spy('Widget') }

    before(:each) do
      allow(widget_class).to receive(:new) { widget }
    end

    def do_get
      get :new
    end

    it 'builds a new widget from the model' do
      do_get

      expect(widget_class).to have_received(:new)
    end

    it 'responds with http success' do
      do_get

      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      do_get

      expect(response).to render_template('widgets/new')
    end

    it 'passes the new widget to the template' do
      do_get

      expect(assigns(:widget)).to eq(widget)
    end
  end

  describe 'POST create' do
    let(:widget) { instance_spy('Widget', persisted?: true) }
    let(:widget_params) { { name: 'Widget', size: '10' } }
    let(:params) { { widget: widget_params } }

    before(:each) do
      allow(widget_class).to receive(:create) { widget }
    end

    def do_post(params = params)
      post :create, params
    end

    it 'attempts to create a new widget' do
      do_post

      expect(widget_class).to have_received(:create).with(widget_params)
    end

    it 'filters invalid data from the request parameters' do
      do_post params.merge(invalid: 'data')

      expect(widget_class).to have_received(:create).with(widget_params)
    end

    it 'checks to see if the operation was a success' do
      do_post

      expect(widget).to have_received(:persisted?)
    end

    describe 'when the widget is valid' do
      before(:each) do
        allow(widget).to receive(:persisted?) { true }
      end

      it 'redirects back to the list of widgets' do
        do_post

        expect(response).to redirect_to(widgets_path)
      end

      it 'sets a flash message' do
        do_post

        expect(flash.notice).to eq('New widget successfully created.')
      end
    end

    describe 'when the widget is invalid' do
      before(:each) do
        allow(widget).to receive(:persisted?) { false }
      end

      it 'renders the new template' do
        do_post

        expect(response).to render_template('widgets/new')
      end

      it 'assigns the faulty widget to the view' do
        do_post

        expect(assigns(:widget)).to eq(widget)
      end
    end
  end
end