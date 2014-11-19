require 'rails_helper'

RSpec.feature 'static pages' do
  scenario 'I can visit the home page' do
    visit '/'

    expect(current_path).to eq('/')
    expect(page).to have_content('Widgets')
  end
end