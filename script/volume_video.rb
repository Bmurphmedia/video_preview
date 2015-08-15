

url = 'http://volume.voxmedia.com/api/videos/2768'


conn = Faraday.new(:url => url) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

response = conn.get ''
hash = ActiveSupport::JSON.decode(response.body)
title = hash["title_short"]
video_assets = hash["video_assets"]

ooyala_id = ''
youtube_id = ''
brightcove_id = ''


video_assets.each do |x|
	#puts "there she is"
	if x["type"] == "OoyalaAsset"
		ooyala_id = x["embed_code"]
	end
	if x["type"] == "YoutubeAsset"
		youtube_id = x["embed_code"]
	end
	if x["type"] == "BrightcoveAsset"
		brightcove_id = x["embed_code"]
	end

end
puts""
puts "Title: " + title
puts "Ooyala: " + ooyala_id
puts "Brightcove: " + brightcove_id
puts "Youtube: " + youtube_id

puts""
puts "hash:\n"
puts hash
