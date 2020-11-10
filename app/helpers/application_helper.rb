module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    email_address = user.email
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  
  def current_user
    #If there is a current user, it simply returns it, else it finds the current user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!! returns a boolean
    !!current_user
  end

end
