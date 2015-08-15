class VideosController < ApplicationController
	before_action :authenticate_user!
	def index
		@videos = Video.all

		@videos.each do |video|
			 video.hash = get_hash(video.volume_id)
		end

	end
	
	def show
		@video = Video.find(params[:id])
		#for getting the current user, if needed
		@user_now = User.find(current_user)
		@user_stored = User.find(@video.user_id)
		@assets = get_assets(@video.volume_id)
	end

	def new
		@video = Video.new
	end

	def create

		@video = Video.new(video_params)
		#get the current user
		@user = User.find(current_user)
		#save the user ID in the instance
		@video.user_id = @user.id

		if @video.save
			redirect_to videos_path(:id)
		else
			render :new
		end
	end

	def edit
		@video = Video.find(params[:id])
	end

	def update
	end

	def destroy
		@video = Video.find(params[:id])
		@video.destroy

		respond_to do |format|
			format.html { redirect_to(videos_url)}
		end
		
	end

	def video_params
		params.require(:video).permit(:volume_id, :image_url)

	end

	

	def get_assets(id)	
		conn = Faraday.new(:url => 'http://volume.voxmedia.com/api/videos') do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end

		response = conn.get id
		hash = ActiveSupport::JSON.decode(response.body)
		title = hash["title_short"]
		assets_array = hash["video_assets"]
		return assets_array
		# assets_array.each do |asset|
		# 	assets_hash = {:type => asset[:]}
		# end

	end



 def get_hash(id)

	conn = Faraday.new(:url => 'http://volume.voxmedia.com/api/videos') do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end

		response = conn.get id
		hash = ActiveSupport::JSON.decode(response.body)
		return hash
	end


end

