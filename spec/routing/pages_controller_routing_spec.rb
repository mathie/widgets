require 'rails_helper'

RSpec.describe 'PagesController' do
  it 'routes / to pages#index' do
    expect(get: '/').to route_to ('pages#index')
  end

  it 'generates / from root_path' do
    expect(root_path).to eq('/')
  end
end