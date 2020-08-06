class SessionsController < ApplicationController

  def new
    # On va juste aller sur la page view new.html.erb
  end

def create
  # cherche s'il existe un utilisateur en base avec l’e-mail
  user = User.find_by(email: params[:email])

  # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
  if user && user.authenticate(params[:password])

    log_in(user) # session[:user_id] = user.id
    puts current_user # fonction dans le helper
     # redirige où tu veux, avec un flash ou pas : Création d'un gossip ? Pourquoi pas ? Ou page des Gossip ?
     redirect_to new_gossip_path
  else
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end
end

  def destroy
    # pour le logout
    session.delete(:user_id)
    redirect_to root_path
  end
end
