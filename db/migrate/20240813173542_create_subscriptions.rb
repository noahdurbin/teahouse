class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :tea, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.string :frequency
      t.string :title

      t.timestamps
    end
  end
end
