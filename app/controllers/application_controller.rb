class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_uri

  WWW_DOMAIN = 'www.higheaglestudios.com'
  def check_uri
    puts Rails.env
    if (request.env['HTTP_HOST'] != WWW_DOMAIN) && Rails.env.production?
      redirect_to "http://#{WWW_DOMAIN}", :status => 301
    end
  end
end
