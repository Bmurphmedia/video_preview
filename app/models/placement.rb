class Placement < ActiveRecord::Base
  attr_accessor :embed_code
  belongs_to :video
  belongs_to :page
end
