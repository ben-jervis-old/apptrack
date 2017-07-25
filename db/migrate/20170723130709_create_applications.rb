class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.integer :amount
      t.string :lender
      t.string :activity
      t.string :waiting_on
      t.integer :owner_id

      t.timestamps
    end
  end
end
