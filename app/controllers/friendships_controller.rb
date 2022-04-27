class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend_id])
    if not friend.blank?
      current_user.friends << friend
      current_user.save
    end
    flash[:notice] = "You are now following your friend #{friend.full_name}"
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy
    flash[:notice] = "You are not friend of #{friend.full_name} anymore"
    redirect_to my_friends_path
  end

end
