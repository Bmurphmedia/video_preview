class Video < ActiveRecord::Base
	has_many :placements
	belongs_to :user
	validates :user, presence: true

	attr_accessor :volume_hash, :youtube_id, :ooyala_id


end
