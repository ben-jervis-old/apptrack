class CreateLenders < ActiveRecord::Migration[5.0]
  def change
    create_table :lenders do |t|
      t.string :name
      t.boolean :favourite
			t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
