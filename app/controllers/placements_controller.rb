class PlacementsController < ApplicationController


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
