require 'rails_helper'

RSpec.describe ShortUrls::Create do
  subject { described_class.new(params_hash).save }
  let(:params_hash) { { short_url: { original_url: 'http://github.com' } } }
  let(:last_short_url) { ShortUrl.last }
  let(:short_url) { FactoryBot.create(:short_url) }

  context 'check service' do
    it 'return true' do
      expect(subject).to be true
    end

    it 'to change objects count' do
      expect { subject }.to change { ShortUrl.count }.from(0).to(1)
    end

    it 'take exist object if url already generate' do
      short_url
      expect(subject.id).to eq(short_url.id)
    end
  end
end
