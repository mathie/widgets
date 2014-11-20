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

  scenario 'finding the "new widget" button' do
    visit '/widgets'

    click_on 'New widget'

    expect(current_path).to eq('/widgets/new')
  end

  scenario 'creating a new widget with valid inputs' do
    visit '/widgets/new'

    within '#new_widget' do
      fill_in 'Name', with: 'Bazzle'
      fill_in 'Size', with: '54'
    end

    click_on 'Create Widget'

    expect(current_path).to eq('/widgets')
    expect(page).to have_content('New widget successfully created.')
  end
end