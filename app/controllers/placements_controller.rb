class PlacementsController < ApplicationController


	def new
		@page = Page.find(params[:page_id])

		@placement = @page.placements.new
	end


	def create
		placement_params = params.require(:placement).permit(:video_id, :option)
		@page = Page.find(params[:page_id])

		@placement = @page.placements.new(placement_params)

		if @placement.save
			redirect_to page_path(@placement.page_id), flash: {success: "Placement Added"}
		else
			render :new
		end

	end






	def show
		@disable_nav = true
		@disable_container = true
		@placement = Placement.find(params[:id])
		@embed_codes = {}
		
		@video = Video.find(@placement.video_id)

		@video.volume_hash = get_volume_hash(@video.volume_id)

		@video.volume_hash["video_assets"].each do |asset|
			
			type = asset["type"]
			@embed_codes["#{type}"] = asset["embed_code"]

		end
		@video.once_id = @embed_codes["BrightcoveAsset"]
		@video.ooyala_id = @embed_codes["OoyalaAsset"]
		@video.youtube_id = @embed_codes["YoutubeAsset"]
	end


	def destroy
		@placement = Placement.find(params[:id])
		@placement.destroy
		redirect_to page_path(@placement.page_id.to_i)

		# respond_to do |format|
		# 	format.html { redirect_to(pages_url)}
		# end
	
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
