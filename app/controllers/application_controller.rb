class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_filter :flash_to_headers

  def flash_to_headers
    return unless request.xhr?

    response.headers['X-Message'] = flash_messages

    flash.discard
  end

  private

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

  def flash_messages
    [:success, :error, :alert, :notice].
        reject { |type| flash[type].blank? }.
        map { |type| "#{type}:#{flash[type]}" }.join(',')
  end
end
