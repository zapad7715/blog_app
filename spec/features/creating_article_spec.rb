require 'rails_helper'

RSpec.feature "Creating Articles" do
  
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')

    login_as(@john)
  end

  scenario "A user creates a new article" do
    visit root_path
    
    click_link t('article.new_article')

    fill_in t('article.title'), with: 'Creating first article.'
    fill_in t('article.body'), with: 'Lorem ipsum.'
    click_button t('article.create_article')

    expect(page).to have_content t('article.flash.success_create')
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content "Created by: #{@john.email}" 
  end

  scenario "A user fails to create a new article" do
    visit root_path

    click_link 'New Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''

    click_button 'Create Article'

    expect(page).to have_content 'Article has not been created'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
    
  end

end
