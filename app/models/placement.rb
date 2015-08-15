class Placement < ActiveRecord::Base
  belongs_to :video
  belongs_to :page
end
