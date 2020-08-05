class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    def create 
       
        idea = Idea.find params[:idea_id]
        like = Like.new(idea: idea, user: current_user)

        if !can?(:like, idea)
            flash[:danger] = "You can't like your own question"
        elsif like.save 
            flash[:success] = 'Question Liked'
        else
            flash[:danger] = like.errors.full_messages.join(', ')
        end

        redirect_to ideas_path
    end

    def destroy 
        
        like = current_user.likes.find params[:id]

        if !can?(:destroy, like)
            flash[:warning] = "You can't destroy a like you don't own"
        elsif like.destroy 
            flash[:success] = "Question Unliked"
        else 
            flash[:warning] = "Couldn't Unlike the question"
        end 

        redirect_to ideas_path
    end
end
