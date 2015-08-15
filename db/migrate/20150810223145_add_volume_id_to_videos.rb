class AddVolumeIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :volume_id, :string
  end
end
