class RemoveImageNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :image_name, :text
  end
end
