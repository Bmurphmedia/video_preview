require 'uri'

def get_hls(url)
	uri = URI(url)
	path = uri.path
	array = path.split(pattern='/',12)

	base_url = "http://once.unicornmedia.com/now/master/playlist/"

	query = uri.query
	extension = "m3u8"
	domain = array[6]
	application = array[7]
	foreign_key = array[8]
	hls = base_url + domain + "/" + application + "/" + foreign_key + "/content.#{extension}?" + query

	puts hls

end

get_hls("http://onceux.unicornmedia.com/now/ads/vmap/od/auto/0c2129c5-42b8-49e0-aa4c-f560c7bc0ba7/af7e1dc1-2f79-49f6-9ebd-9ef0559a1ed5/6720000004/content.once?&UMPTPARAMcmsid=3424&UMPTPARAMvid=1yb3J0dTrZtwE7qk38reXKV9K6LUo_i1&UMPTPARAMplayer=brightcove")


# url ="http://onceux.unicornmedia.com/now/ads/vmap/od/auto/0c2129c5-42b8-49e0-aa4c-f560c7bc0ba7/af7e1dc1-2f79-49f6-9ebd-9ef0559a1ed5/6720000004/content.once?&UMPTPARAMcmsid=3424&UMPTPARAMvid=1yb3J0dTrZtwE7qk38reXKV9K6LUo_i1&UMPTPARAMplayer=brightcove"
# uri = URI(url)

# puts "Scheme " + uri.scheme
# puts "Host " + uri.host
# puts "Path " + uri.path 
# puts "Query " + uri.query
# puts "fragment" + uri.fragment.to_s

# puts uri.to_s

# string = uri.path

# array = string.split(pattern='/',12)

# array.each do |x|
# 	puts x 
# end

# puts array
# puts ""
# puts array[6]


# base_url = "http://once.unicornmedia.com/now/od/adaptive/"
# extension = "m3u8"
# domain = array[6]
# application = array[7]
# foreign_key = array[8]
# query = uri.query

