module ShortUrls
  class Create
    attr_reader :short_url

    def initialize(params)
      @params = params
      @short_url = ShortUrl.new
    end

    def save
      @short_url.attributes = prepared_attributes
      @short_url.sanitize
      @short_url.find_duplicate.nil? ? @short_url.save : @short_url.find_duplicate
    end

    private

    attr_reader :params

    def prepared_attributes
      { original_url: params[:short_url][:original_url] }
    end
  end
end
