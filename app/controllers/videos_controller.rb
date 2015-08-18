class VideosController < ApplicationController
	before_action :authenticate_user!
	def index
		@videos = Video.all

		@videos.each do |video|
			 video.volume_hash = get_volume_hash(video.volume_id)
		end

	end
	
	def show
		@video = Video.find(params[:id])
		#for getting the current user, if needed
		@video.volume_hash = get_volume_hash(@video.volume_id)
		@user_now = User.find(current_user)
		@user_stored = User.find(@video.user_id)
		
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
		
		if get_volume_hash(@video.volume_id) != "error"		
			if @video.save
				flash[:success] = "Video Created!"
				redirect_to videos_path(:id)
			else
				flash[:error] = "Something weird happened"
				render :new
			end
		else
			flash[:error] = "Invalid Volume ID, try again"
			render :new
		end
	end
	

	def edit
		@video = Video.find(params[:id])
		
	end

	def update
		@video = Video.find(params[:id])
		if @video.update_attributes(video_params)
			redirect_to videos_path
		else
			render :new
		end
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

