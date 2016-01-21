require 'rails_helper'

RSpec.feature "Creating Articles" do
  
  scenario "A user creates a new article" do
    visit root_path
    
    click_link t('article.new_article')

    fill_in t('article.title'), with: 'Creating first article.'
    fill_in t('article.body'), with: 'Lorem ipsum.'
    click_button t('article.create_article')

    expect(page).to have_content t('article.flash.success_create')
    expect(page.current_path).to eq(articles_path)
  end

end
