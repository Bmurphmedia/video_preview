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
		@video_placements = []

		count = 0
		@placements.each do |placement|
			video = Video.find(placement.video_id)
			@video_placements[count] = {placement_id: placement.id, video_id: placement.video_id, option: placement.option, video_data: get_volume_hash(video.volume_id)}
			count = count+1
		end


	end




	def page_params
		params.require(:page).permit(:title, :description)

	end
	def get_volume_hash(id)

		conn = Faraday.new(:url => 'http://volume.voxmedia.com/api/videos') do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end

		response = conn.get id
		hash = ActiveSupport::JSON.decode(response.body)
		rescue 
			return "error"
		return hash
	end


end
