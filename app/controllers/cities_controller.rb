class CitiesController < ApplicationController
  
  def index
    @cities = City.all
  end


  def show
    @city = City.find(params[:id])
  end


  def new
    # Méthode qui crée une ville vide et l'envoie dans une view qui affiche le formulaire pour création
    @ncity = City.new
  end

  # Méthode qui créé une ville à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
  # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
  # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  def create
    
    @city = City.new(
      name: params[:name], 
      zip_code: params[:zip_code]
    )
    
    if @city.save
      redirect_to city_path(@city.id) #, :flash => { :success => "Votre ville a été créé" }
    else
      render new_city_path # renvoie à la page new 
    end
    
  end


end
