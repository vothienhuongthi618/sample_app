class PostsController < ApplicationController 
	before_filter :signed_in_user, only: [:create, :destroy, :update]
	before_filter :correct_user,   only: :destroy

	def index
		@state = params[:state] || {}
		@posts = Post.where(@state).paginate(page: params[:page])
	end 

	def show
	  @post = Post.find(params[:id])
	 
	  respond_to do |format|
	    format.html  # show.html.erb
	    format.json  { render :json => @post }
	  end
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

	def edit
		@post = Post.find(params[:id])
	end

	def update
	  @post = Post.find(params[:id])
 
	  respond_to do |format|
	    if @post.update_attributes(params[:post])
	      format.html  { redirect_to(@post,
	                    :notice => 'Post was successfully updated.') }
	      format.json  { head :no_content }
	    else
	      format.html  { render :action => "edit" }
	      format.json  { render :json => @post.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
	end

	def destroy
		@post.update_attributes(state: 3)
		redirect_to root_url
	end

	private
		def correct_user
			@post = current_user.posts.find_by_id(params[:id])
			redirect_to root_url if @post.nil?
		end

		def correct_user
			@post = current_user.posts.find_by_id(params[:id])
			redirect_to root_url if @post.nil?
		end
end
