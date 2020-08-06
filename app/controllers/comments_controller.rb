class CommentsController < ApplicationController
  # Une session doit être ouverte
  before_action :authenticate_user, only: [:show, :new, :create]
  # On doit être l'auteur du commentaire pour le modifier ou le détruire
  before_action :authenticate_comment_author, only: [:edit, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
    # Faut-il retrouver le gossip ? 
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(content: params.require(:comment))
    @gossip = Gossip.find(params[:gossip_id])
    @comment.user = current_user
    @comment.gossip = @gossip
    # user_ano = User.find_by(first_name: "anonymous")
    # @comment = Comment.create(content: params.require(:comment), user: user_ano, gossip: @gossip)
    @comment.save
    
    redirect_to gossip_path(@gossip.id)
  end


  def update
    @comment = Comment.find(params[:id])
    @post_params = params.require(:comment).permit(:content)
    @comment.update(@post_params)
    redirect_to gossip_path(params[:gossip_id])
  end


  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @comments = @gossip.comments
      render 'gossips/show'
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate_user #On vérifie que la personne est bien conncectée avant de l'autoriser à écrire un commentaire
    unless current_user
      flash[:danger] = "Merci de vous connecter"
      redirect_to new_session_path
    end
  end

  def authenticate_comment_author #Une personne ne peut modifier / détruire que ses propres commentaires
    comment = Comment.find(params[:id])
    unless current_user == comment.user
      flash[:danger] = "Vous ne pouvez pas modifier ou supprimer un commentaire dont vous n'êtes pas l'auteur"
      redirect_to gossip_path(@gossip.id)
    end
  end

end
