class Video < ActiveRecord::Base
	has_many :placements
	belongs_to :user
	validates :user, presence: true

	attr_accessor :volume_hash, :youtube_id, :ooyala_id




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
