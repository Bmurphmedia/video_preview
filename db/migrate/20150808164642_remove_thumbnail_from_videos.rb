class RemoveThumbnailFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :thumbnail, :string
  end
end
