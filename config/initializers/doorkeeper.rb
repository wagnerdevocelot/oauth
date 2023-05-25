Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    current_user || redirect_to(new_user_session_url)
  end

  resource_owner_authenticator do
    user_id = session["warden.user.user.key"][0][0] rescue nil
    User.find_by_id(user_id) || begin
      session['user_return_to'] = request.url
      redirect_to(new_user_session_url)
    end
  end

  force_ssl_in_redirect_uri false

  skip_authorization do
    true
  end
end
