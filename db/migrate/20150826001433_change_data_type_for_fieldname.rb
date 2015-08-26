class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.change :user_id , :integer
    end
  end
  def self.down
    change_table :pages do |t|
      t.change :user_id, :string
    end
  end

end
