class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #authorize_resource
  #skip_load_and_authorize_resource  :only => [:new, :create, :destroy]

  def access_denied(exception)
    redirect_to admin_organizations_path, alert: exception.message
  end

  def has_internet?
    require "resolv"
    dns_resolver = Resolv::DNS.new()
    begin
      dns_resolver.getaddress("symbolics.com")#the first domain name ever. Will probably not be removed ever.
      return true
    rescue Resolv::ResolvError => e
      return false
    end
  end

  # def authenticate_admin_user!
  #   # if !current_user.admin?
  #   #   redirect_to new_user_session_path
  #   # end
  # end

end
