class FriendsController < ApplicationController

  def search
    if friends_params.present?
      @friends= User.where("email = ? OR first_name ILIKE ? OR last_name ILIKE ?", friends_params, "%#{friends_params}%", "%#{friends_params}%")
      @friends = @friends.reject {|u| u.id == current_user.id }
      if @friends
        respond_to do |format|
          format.js {render partial: 'friends/friend'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid e-mail!"
          format.js {render partial: 'friends/friend'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a e-mail to search"
        format.js {render partial: 'friends/friend'}
      end
    end
  end

  private

  def friends_params
    params[:friend]
  end


end
