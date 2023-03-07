class RelationshipsController < ApplicationController
    
    def create
      
      follower=current_user.follower.new(followed_id: params[:user_id])
      follower.save
      redirect_to request.referer
    end
    
    def destroy
      follower=current_user.follower.find_by(followed_id: params[:user_id])
      follower.destroy
      redirect_to request.referer
    end
        
        
    def follows
      user = User.find(params[:id])
      @users = user.following_user.page(params[:page]).per(3).reverse_order
    end
    
    def followers
      user = User.find(params[:id])
      @users = user.follower_user.page(params[:page]).per(3).reverse_order
    end
end
