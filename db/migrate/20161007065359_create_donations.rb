class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.belongs_to :period
      t.string :receipt_no
      t.string :name, null: false
      t.text :address
      t.string :phone
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
