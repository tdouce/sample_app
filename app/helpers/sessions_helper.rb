module SessionsHelper

  def sign_in( user )
    cookies.permanent.signed[:remember_token] = [ user.id, user.salt ]
    self.current_user = user
  end

  def current_user=(user) 
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end


  def authenticate
    deny_access unless signed_in?
  end


  
  # Used in Users controller in before_filter
  def deny_access
    store_location
    # :notice is an options hash equivalent to flash[:notice]
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def current_user
    @current_user ||= user_from_remember_token 
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Put methods here that are never needed outside the SesssionHelper
  private
    
    def user_from_remember_token
      User.authenticate_with_salt( *remember_token )
    end

    def remember_token
      cookies.signed[:remember_token] || [ nil, nil ]
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end
