require 'rails_helper'

RSpec.feature 'Managing widgets' do
  scenario 'Finding the list of widgets' do
    visit '/'

    click_on 'List widgets'

    expect(current_path).to eq('/widgets')
  end

  scenario 'Listing widgets' do
    Widget.create! name: 'Frooble', size: 20
    Widget.create! name: 'Barble',  size: 42

    visit '/widgets'

    expect(page).to have_content('Frooble (20mm)')
    expect(page).to have_content('Barble (42mm)')
  end
end