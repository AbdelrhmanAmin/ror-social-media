class FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new(friendship_params)
  end
  
  def create
    @friendship = Friendship.create!(friendship_params)

    if @friendship.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def confirm
    friendship = Friendship.find(params[:id])
    friendship.confirmed = true
    friendship.save
    redirect_to users_path
  end
  def reject
    friendship = Friendship.find(params[:id])
    friendship.confirmed = false
    user = User.find(friendship.user_id)
    friend = User.find(friendship.friend_id)
    Friendship.where(user:user, friend: friend).first.delete
    friendship.save
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])

    if @friendship.update_attributes(friendship_params)
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_path
  end
  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed, :id)
  end
end