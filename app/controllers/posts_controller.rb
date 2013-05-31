class PostsController < ApplicationController 
	before_filter :signed_in_user, only: [:create, :destroy, :update]

	def index
	end 

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def update
	end

	def destroy
	end
end
