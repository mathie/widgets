require 'rails_helper'

RSpec.describe 'WidgetsController' do
  it 'routes GET /widgets to widgets#index' do
    expect(get: '/widgets').to route_to('widgets#index')
  end

  it 'generates /widgets from widgets_path' do
    expect(widgets_path).to eq('/widgets')
  end
end
