class RemoveActivityFromApplications < ActiveRecord::Migration[5.0]
  def change
		remove_column :applications, :activity
		add_column :applications, :activity_id, :integer
  end
end
