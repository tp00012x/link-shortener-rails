class ShortLinksController < ApplicationController
  before_action :fetch_short_link, only: [:show, :update, :admin]
  after_action :increment_view_count, only: :redirect_to_original_url

  def new
    @short_link = ShortLink.new
  end

  def create
    @short_link = ShortLink.find_by(original_url: parsed_original_url) ||
        ShortLink.create(original_url: parsed_original_url)

    redirect_to @short_link
  end

  def show
    @id = @short_link.id
    @short_url = "http://localhost:3000/s/#{@id}"
  end

  def update
    @short_link.update_attribute(:expired, true) if expired?

    redirect_to @short_link
  end

  def admin
  end

  def redirect_to_original_url
    link = ShortLink.find(params[:short_url])

    not_found if link.expired

    redirect_to "http://#{link.original_url}"
  end

  private

  def parse_url(url)
    url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def parsed_original_url
    unparsed_original_url = params.dig(:short_link, :original_url)

    parse_url(unparsed_original_url)
  end

  def fetch_short_link
    @short_link = ShortLink.find(ShortLink.decrypt(params[:id]))
  end

  def increment_view_count
    ShortLink.increment_counter(:view_count, params[:short_url])
  end

  def expired?
    params[:commit] == 'Expire' ? true : false
  end
end