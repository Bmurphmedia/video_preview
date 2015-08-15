class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :volume_url
      t.string :response
      t.string :title
      t.string :ooyala_id
      t.string :youtube_id
      t.string :once_id
      t.string :image_url

      t.timestamps null: false
    end
  end
end
