class StaticController < ApplicationController

  def welcome
    # pour transmettre à la page Welcome
    @user = params[:name]
  end

  def team
  end

  def contact
  end

end
