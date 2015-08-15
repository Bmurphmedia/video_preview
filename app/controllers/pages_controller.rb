class PagesController < ApplicationController
	def show
		@page = Page.find(params[:id])
		@placements = @page.placements
		@videos = []

		video_ids = []
		count = 0
#For each placement find the related video model and store it in a spot in an array addressable with that same id
		@placements.each do |x|
			@videos[x.video_id] = Video.find(x.video_id)

			count = count + 1
		end

		@dump = "Pizza"




	end
end
