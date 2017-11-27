require 'rails_helper'

describe 'feature check short url', type: :feature do
  let(:short_url) { FactoryBot.create(:short_url) }

  context 'short url' do
    before(:each) do
      visit root_path
    end

    it 'create successfully' do
      fill_in I18n.t('forms.email_placeholder'), with: 'http://github.com'
      click_button I18n.t('forms.generate_button')
      expect(page).to have_content I18n.t('notices.success_create_url')
    end

    it 'already exist' do
      short_url
      fill_in I18n.t('forms.email_placeholder'), with: 'http://github.com'
      click_button I18n.t('forms.generate_button')
      expect(page).to have_content I18n.t('notices.url_already_generate')
    end
  end

  context 'short url is not' do
    it 'valid' do
      visit root_path
      fill_in I18n.t('forms.email_placeholder'), with: 'wrong url'
      click_button I18n.t('forms.generate_button')
      expect(page).to have_content I18n.t('alerts.broken_url')
    end
  end
end
