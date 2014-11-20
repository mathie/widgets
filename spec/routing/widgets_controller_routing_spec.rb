require 'rails_helper'

RSpec.describe 'WidgetsController' do
  it 'routes GET /widgets to widgets#index' do
    expect(get: '/widgets').to route_to('widgets#index')
  end

  it 'routes GET /widgets/new to widgets#new' do
    expect(get: '/widgets/new').to route_to('widgets#new')
  end

  it 'routes POST /widgets to widgets#create' do
    expect(post: '/widgets').to route_to('widgets#create')
  end

  it 'generates /widgets from widgets_path' do
    expect(widgets_path).to eq('/widgets')
  end

  it 'generates /widgets/new from new_widget_path' do
    expect(new_widget_path).to eq('/widgets/new')
  end
end
