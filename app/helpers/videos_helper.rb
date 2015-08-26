module VideosHelper
	def volume_url(volume_id)
		"https://volume.voxmedia.com/admin/videos/#{volume_id}" 
	end
	#takes the onceux vmap url as an argument
	def get_hls(url)
		#creates URI object to help breakup URL
		uri = URI(url)
		path = uri.path
		#gets the components out of the path
		array = path.split(pattern='/',12)
		#current base URL for HLS file
		base_url = "http://once.unicornmedia.com/now/master/playlist/"
		#captures query string from URI
		query = uri.query
		#An optional query string to ad to reduce the streams available
		profile = "&umoprofiles=mobile"
		extension = "m3u8"
		#assigns useful pieces of the path to variables
		domain = array[6]
		application = array[7]
		foreign_key = array[8]
		#constructs the new url 
		hls = base_url + domain + "/" + application + "/" + foreign_key + "/content.#{extension}?" + query 
		return hls
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
