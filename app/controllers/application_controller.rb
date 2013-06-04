class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include PostsHelper


  # Force signout to prevent CSRF attacks
  def handle_inverified_request
  	signout
  	super
  end

end
