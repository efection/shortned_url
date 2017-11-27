class ShortUrl < ApplicationRecord
  UNIQUE_ID_LENGTH = 6
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url, with: URI::regexp(%w[http https])

  before_create :generate_short_url
  before_create :sanitize

  def generate_short_url
    url = ([*('a'..'z'), *('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
    old_url = ShortUrl.where(short_url: url).last
    old_url.present? ? generate_short_url : self.short_url = url
  end

  def find_duplicate
    ShortUrl.find_by_sanitize_url(sanitize_url)
  end

  def sanitize
    original_url.strip!
    self.sanitize_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    self.sanitize_url = "http://#{sanitize_url}"
  end
end
