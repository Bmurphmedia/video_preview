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
		#Assign the specificed instance of page to an instance variable
		@page = Page.find(params[:id])
		#Assign all the instences of placements that relate to page to an instance variable
		@placements = @page.placements
		#Initiliaze and array to hold data for each video specified in the placement
		@video_placements = []

		#initialize a counter variable
		count = 0
		#iterate through placements to to fill @video_placements up with the information needed for the view
		@placements.each do |placement|
			#Lookup the video that relates to this placement
			video = Video.find(placement.video_id)
			#add a data hash to this array that includes data from the video model and the related data from the API
			@video_placements[count] = {placement_id: placement.id, video_id: placement.video_id, option: placement.option, image_url: video.image_url, video_data: get_volume_hash(video.volume_id)}
			#increment count
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
