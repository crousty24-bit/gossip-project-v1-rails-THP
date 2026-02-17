class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  def current_user
    User.second
  end
end
