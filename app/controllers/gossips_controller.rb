class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:show, :new, :create]
  before_action :currentuser_gossipauthor?, only: [:edit, :update, :destroy]


  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def update
    @gossip = Gossip.find(params[:id])

    if @gossip.update(gossip_params)
      redirect_to @gossip
      # redirect_to gossip_path # renvoie à la page principale des potins
    else
      render :edit
    end

  end

  def create
    @gossip = Gossip.new(gossip_params) # avec les données obtenues à partir du formulaire (+ les autorisations)

    @gossip.user = current_user
    # ===================================================================

    if @gossip.save # Si la sauvegarde en base de @gossip est un succès :
      flash[:succes] = "Votre potin a été crée !"
      redirect_to gossip_path(@gossip.id) #, :flash => { :success => "Votre Gossip a été créé" }
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      render new_gossip_path # 'new'
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end

private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end

  def currentuser_gossipauthor?
    unless current_user == Gossip.find(params[:id]).user
      flash[:danger] = "Vous ne pouvez pas supprimer un potin dont vous n'êtes pas l'auteur"
      redirect_to gossip_path(Gossip.find(params[:id]).id)
      # redirect_to root_path gossip_path()
    end
  end

end
