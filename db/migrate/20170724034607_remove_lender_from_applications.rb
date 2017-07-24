class RemoveLenderFromApplications < ActiveRecord::Migration[5.0]
  def change
		remove_column :applications, :lender
		add_column :applications, :lender_id, :integer
  end
end
