require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:short_url) { FactoryBot.create(:short_url) }

  context 'check short code' do
    it 'generate successfully' do
      expect(short_url.short_url).to_not eq(nil)
    end
  end

  context 'check sanitize url' do
    it 'create successfully' do
      expect(short_url.sanitize_url).to eq(short_url.sanitize)
    end
  end
end
