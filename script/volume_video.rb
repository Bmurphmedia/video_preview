puts 'test'


def get_volume_hash(id)

	conn = Faraday.new(:url => 'http://volume.voxmedia.com/api/videos') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end

	response = conn.get id

		
	hash = ActiveSupport::JSON.decode(response.body)
	return hash
	# rescue
	# 	return "error"
	
	

end
puts get_volume_hash('5000')