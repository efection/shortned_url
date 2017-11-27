FactoryBot.define do
  factory :short_url do
    original_url 'http://github.com'
    sanitize_url 'http://github.com'
  end
end
