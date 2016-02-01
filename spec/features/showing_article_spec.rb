require 'rails_helper'

RSpec.feature "Showing an Article" do
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'The first article', body: 'Body of first article', user: @john)
  end

  scenario 'A non-signed in user does not see Edit or Delete links' do
    visit root_path

    click_link @article.title

    expect(current_path).to eq article_path(@article)
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body

    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end

  scenario 'A non-owner signed-in user cannot see Edit or Delete links' do
    login_as(@fred)

    visit root_path

    click_link @article.title

    expect(current_path).to eq article_path(@article)
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body

    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end

  scenario 'A signed-in owner sees Edit and Delete links' do
    login_as(@john)

    visit root_path

    click_link @article.title

    expect(current_path).to eq article_path(@article)
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body

    expect(page).to have_link 'Edit Article'
    expect(page).to have_link 'Delete Article'
  end

  scenario 'Display individual article' do
    visit root_path

    click_link @article.title

    expect(current_path).to eq article_path(@article)
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
  end
end
