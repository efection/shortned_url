class ShortUrlsController < ApplicationController
  def index
    @url = ShortUrl.new
  end

  def show
    @url = ShortUrl.find(params[:id])
    host = request.host_with_port
    @original_url = @url.sanitize_url
    @short_url = host + '/' + @url.short_url
  end

  def create
    service = ShortUrls::Create.new(params)
    service_url = service.save

    if service_url == true
      flash[:notice] = t('notices.success_create_url')
      redirect_to short_url_path(service.short_url)
    elsif service_url
      flash[:notice] = t('notices.url_already_generate')
      redirect_to short_url_path(service_url)
    else
      flash[:error] = t('alerts.broken_url')
      redirect_to root_path
    end
  end

  def eject_url
    fetch_url = ShortUrl.find_by_short_url(params[:short_url])
    redirect_to fetch_url.sanitize_url
  end
end
