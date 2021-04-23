class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.decimal :prev_balance
      t.decimal :balance
      t.decimal :income
      t.decimal :expenses
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
