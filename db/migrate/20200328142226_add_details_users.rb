class AddDetailsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false, default: "AddFirstName"
    add_column :users, :last_name, :string, null: false, default: "AddLastName"
    add_column :users, :address, :string, null: false, default: "AddAddress"
    add_column :users, :phone1, :string, null: false, default: "AddPhone1"
    add_column :users, :phone2, :string, null: true, default: ""
    add_column :users, :email2, :string, null: true, default: ""
    add_column :users, :contact, :string, null: true, default: ""
    add_column :users, :itin, :integer, null: true, default: ""
    add_column :users, :ein, :integer, null: true, default: ""
    add_column :users, :is_client, :boolean, null: false, default: true
    add_column :users, :is_partner, :boolean, null: false, default: false
    add_column :users, :is_admin, :boolean, null: false, default: false    
  end
end
