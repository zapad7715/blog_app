require 'rails_helper'

RSpec.feature "Showing an Article" do
  before do
    @article = Article.create(title: 'The first article', body: 'Body of first article')
  end

  scenario 'Display individual article' do
    visit root_path

    click_link @article.title

    expect(current_path).to eq article_path(@article) 
    expect(page).to have_content @article.title 
    expect(page).to have_content @article.body 
  end
end
