class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user
    session[:user_id] ||= SecureRandom.uuid
  end
end
