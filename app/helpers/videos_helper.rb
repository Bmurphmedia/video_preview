module VideosHelper
	def volume_url(volume_id)
		"https://volume.voxmedia.com/admin/videos/#{volume_id}" 
	end
	#takes the onceux vmap url as an argument
	def brightcove_url(vmap_url,type)
	    uri = URI(vmap_url)
	    path = uri.path

	    # gets the components out of the path
	    array = path.split('/', 12)

	    if type == "hls"
	        # current base URL for HLS file
	        base_url = "http://once.unicornmedia.com/now/master/playlist/"
	        extension = "m3u8"
	    
	    elsif type == "auto"
	        base_url = "http://once.unicornmedia.com/now/od/auto/"
	        extension = "once"
	    end

	    # captures query string from URI
	    query = uri.query

	    # assigns useful pieces of the path to variables
	    domain = array[6]
	    application = array[7]
	    foreign_key = array[8]

	    # constructs the new url
	    url = base_url + domain + "/" + application + "/" + foreign_key + "/content.#{extension}?" + query

	    return url
	  end
	def ooyala_mp4(id)

		return "http://ak.c.ooyala.com/#{@video.ooyala_id}/DOcJ-FxaFrRg4gtDEwOmk2OjBrO6qGv_"

	end


	# def get_youtube_id(url)
	# conn = Faraday.new(:url => url) do |faraday|
	#   faraday.request  :url_encoded             # form-encode POST params
	#   faraday.response :logger                  # log requests to STDOUT
	#   faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	# end

	# response = conn.get ''
	# hash = ActiveSupport::JSON.decode(response.body)
	# title = hash["title_short"]
	# video_assets = hash["video_assets"]

	# video_assets.each do |x|

	# 	if x["type"] == "YoutubeAsset"
			
	# 		return x["embed_code"]
	# 	end

	# end



	# end
end
