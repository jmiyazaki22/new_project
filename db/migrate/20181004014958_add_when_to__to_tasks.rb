class AddWhenToToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :when_to, :date
  end
end
