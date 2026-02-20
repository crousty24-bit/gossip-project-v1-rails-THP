module SessionsHelper
  def current_user
    if session[:user_id]
      # S'il y a une session, on l'utilise (comportement classique)
      @current_user = User.find_by(id: session[:user_id])
      
    elsif cookies[:user_id]
      # S'il n'y a pas de session mais un cookie, on cherche l'utilisateur lié
      user = User.find_by(id: cookies[:user_id])
      
      # On vérifie que l'utilisateur existe ET que le token du cookie correspond au digest en BDD
      if user && user.remember_digest && BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
        session[:user_id] = user.id # On recrée la session temporaire pour naviguer plus vite ensuite
        @current_user = user
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    # On génère un token aléatoire (une suite de caractères au hasard)
    remember_token = SecureRandom.urlsafe_base64

    # On utilise la méthode de ton modèle User pour hasher et sauvegarder ce token en BDD
    user.remember(remember_token)

    # On stocke l'ID et le token en clair dans les cookies permanents (pour 20 ans !) du navigateur
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def forget(user)
    # on remet le remember_digest à nil puisqu'il ne nous servira plus :
    user.update_attribute(:remember_digest, nil)
    # on efface les cookies dans le navigateur de l'utilisateur
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out(user)
    session.delete(:user_id)
    forget(user)
    @current_user = nil
  end
end