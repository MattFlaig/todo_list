class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #checks for presence of current_user
  end

  private
  
  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def locale_path(locale)
    locale_regexp = %r{/(en|de)/?}
    if request. env['PATH_INFO'] =~ locale_regexp
      "#{request.env['PATH_INFO']}".
      gsub(locale_regexp, "/#{locale}/")
    else
      "/#{locale}#{request.env['PATH_INFO']}"
    end
  end
  helper_method :locale_path
end

