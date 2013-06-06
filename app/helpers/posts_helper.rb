module PostsHelper
  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end


	def current_state=(state)
		@current_state = state
	end

	def current_state
		@current_state ||= state_from_remember_token
	end

	def current_state?(state)
    	state == current_state
  	end
end