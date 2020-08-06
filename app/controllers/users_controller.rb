class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    puts "NEW USER CONTROLLER*"
    puts "*"*72
    @user = User.new
  end


  # Création d'un utilisateur avec mot de passe !
  def create
    
    puts "*"*72
    puts "CREATE USER CONTROLLER* ___________________________________"
    puts "*"*72

    city = City.find_by(name: params[:city])

      puts city.inspect

    if city == nil
      puts "VILLE NON TROUVEE"
      city = City.last #On le position à la dernière ville s'il ne la trouve pas
    end
    
    puts city.inspect
    puts params.inspect
    
    @user = User.new(
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      description: params[:description],
      email: params[:email],
      age: params[:age],
      password: params[:password],
      city: city
    )
    
    if @user.save
      # session[:user_id] = @user.id
      log_in(@user) # session[:user_id] = user.id
      redirect_to root_path, :flash => { :success => "Votre utilisateur a été créé" }
      # redirect_to users_path, :flash => { :success => "Votre utilisateur a été créé" }
    else
      render 'new'
    end

  end

end
