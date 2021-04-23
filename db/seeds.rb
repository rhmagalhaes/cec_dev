# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# def change
#     create_table :vehicles do |t|
#       t.string :make
#       t.string :model
#       t.integer :year
#       t.integer :registration
#       t.string :tag
#       t.string :dealer_address
#       t.integer :dealer_phone
#       t.string :dealer_contact
#       t.string :dealer_hours

#       t.timestamps
#     end
#   end


#   def change
#     create_table :units do |t|
#       t.string :building_name
#       t.string :address
#       t.string :contact_name
#       t.string :contact_phone
#       t.string :contact_email
#       t.integer :bedrooms
#       t.integer :bathrooms
#       t.integer :windows
#       t.string :AC_filter_size

#       t.timestamps
#     end
#   end

#   def change
#     create_table :levels do |t|
#       t.string :name
#       t.decimal :share_bonus
#       t.decimal :cash_bonus

#       t.timestamps
#     end
#   end

User.create({ :email => "cliente01@casa.com", :password => "123456", :first_name => "Cliente01", :last_name => "Sobrenome01", 
    :address => "Endereço 01", :phone1 => "305-123-0001", :is_client => true}) 
User.create({ :email => "cliente02@casa.com", :password => "123456", :first_name => "Cliente02", :last_name => "Sobrenome02", 
    :address => "Endereço 02", :phone1 => "305-123-0002", :is_client => true}) 
User.create({ :email => "cliente03@casa.com", :password => "123456", :first_name => "Cliente03", :last_name => "Sobrenome03", 
    :address => "Endereço 03", :phone1 => "305-123-0003", :is_client => true}) 
User.create({ :email => "cliente04@casa.com", :password => "123456", :first_name => "Cliente04", :last_name => "Sobrenome04", 
    :address => "Endereço 04", :phone1 => "305-123-0004", :is_client => true})     

User.create({ :email => "admin01@casa.com", :password => "123456", :first_name => "Admin01", :last_name => "Sobrenome11", 
    :address => "Endereço 11", :phone1 => "305-123-0011", :is_client => false, :is_admin => true}) 

User.create({ :email => "partner01@casa.com", :password => "123456", :first_name => "Partner01", :last_name => "Sobrenome21", 
    :address => "Endereço 03", :phone1 => "305-123-0021", :is_client => false, :is_partner => true})
User.create({ :email => "partner02@casa.com", :password => "123456", :first_name => "Partner02", :last_name => "Sobrenome22", 
        :address => "Endereço 03", :phone1 => "305-123-0022", :is_client => false, :is_partner => true}) 



# 50.times do
#     user=User.new(
#         name: Faker::Internet.user_name,
#         email: Faker::Internet.email,
#         password: Faker::Internet.password
#     )
#     user.save!
#     end
    
    
#     users = User.order(:created_at).take(6)
#     20.times do
#     content = Faker::Lorem.sentence(5)
#     users.each { |user| user.diaries.create!(content: body) }
#     end