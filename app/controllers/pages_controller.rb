class PagesController < ApplicationController
	def index
		@pages = Page.all
	end

	def new
		@page = Page.new
	end

	def create

		@page = Page.new(page_params)
		#get the current user
		@user = User.find(current_user)
		#save the user ID in the instance
		@page.user_id = @user.id

		if @page.save
				flash[:success] = "page Created!"
				redirect_to pages_path(:id)
			else
				flash[:error] = "Something weird happened"
				render :new
			end

	end



	def show
		@page = Page.find(params[:id])
		@placements = @page.placements
		
		#starting out with making all videos available, 
		#but should limit to videos that relate to placements
		@videos= Video.all

		@videos.each do |video|
			 video.volume_hash = video.get_volume_hash(video.volume_id)
		end


	end




	def page_params
		params.require(:page).permit(:title, :description)

	end


end
