class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.string :name, null: false
      t.integer :status_cd, null: false, limit: 1

      t.timestamps
    end
  end
end
