# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
Devise initial configuration
Add details on user table
* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

>>>> Project commands <<<<<

Description of the project

> > > CREATING NEW APP

Create directory in github.com
bash comand line
git clone ...
rails new app_name -s

> > > INSTALL BOOTSTRAP/WEBPACK

Step 1:
yarn add bootstrap jquery popper.js

Step 2:
in config/webpack/environment.js add the following:

const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

module.exports = environment

Step 3:
in app/javascript/packs/application.js add the following:

require("bootstrap/dist/js/bootstrap")

note: doesn't need to import jquery , popper once initialized as webpacker plugin

step 4:
in app/assets/stylesheets/application.css add the following:
@import "bootstrap/scss/bootstrap";
or
*= require bootstrap/scss/bootstrap
note: rails-sass can pick file from node modules
This get bootstrap 4 up and running with Rails 6 Beta and webpack!

> > > MIGRATION

edit file gemfile
add gem 'devise', '~> 4.7', '>= 4.7.1'
run bundle

run rails generate devise:install
edit file app/views/layouts/application.html.erb
add <%= render partial :errormessage %>
create file app/views/layouts/_errormessage.html.erb
add    <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>
edit file config/environments/development.rb
add config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
edit file config/routes.rb
add  "home#index"

rails g devise:views

run rails generate devise User
-> create user table with devise to allow session login to the system

edit file app/model/user.rb
add :confirmable
edit file db/migrate/*_devise_create_users.rb
uncomment items of confirmable

rails g migration 

AddDetailsUsers 
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

rails g scaffold Level name:string share_bonus:decimal cash_bonus:decimal users:references
--> Create the table LEVEL where share_bonus is the percent extra over the total services a partner receive for every new client he brings and cash_bonus is the amount of cash extra a partner receive each month for every 10 services in the month

rails g scaffold Units building_name:string address:string contact_name:string contact_phone:string contact_email:string bedrooms:integer bathrooms:integer windows:integer AC_filter_size:string 
--> Create table UNITS where all information about all units a user has is stored
id_user:integer has_vehicle:boolean

rails g scaffold Vehicles make:string model:string year:integer registration:integer tag:string dealer_address:string dealer_phone:integer dealer_contract:string dealer_hours:string
--> Create table VEHIVLES where all information about all vehicles a user has is stored

rails g migration CreateUserUnits realtor_name:string realtor_phone:string buy_date:datetime has_tennant:boolean users:references units:references
--> associate where each vehicle is parked ONE-TO-MANY

rails g migration CreateUnitVehicles parking_spot:string parking_lv:integer has_valet:boolean units:references vehicles:references
--> associate where each vehicle is parked ONE-TO-MANY

run rails db:migrate

> > > BASIC CONTROLLER

# welcome/index is the landpage before log in
run rails g controller welcome index

# dashboard/index is the landpage after log in
run rails g controller dashboard index



rails g scaffold UserType user_type:string
        # user_type [0 => "admin", 1=> "client", 2 => "employee", 3 => "audit"]
        
edit db/migrate/*_create_user_types to update the line t.integer :user_type, default: 1, null: false

rails g scaffold ServiceRequest         date_open:datetime date_close:datetime

rails g scaffold ServiceExecution       value_charged:decimal note:string

rails g scaffold ServiceDetail          name:string price:decimal                

rails g scaffold UserServiceExecution   profit:decimal date_payment:datetime 

> > > MODELS

Class Models(USERS)
    has_one :user_details
    has_one :user_types, through => :user_details
end
Class UserDetail
    belongs_to :models
    has_one :user_types
end
Class UserType
    belgongs_to :user_details
end

M 1 - 1 UD 1 - 1 UT

-------------

Class Models(USERS - Employee)
    has_many :service_executions
    has_one :service_details, through => :service_executions
end
Class Service_execution
    belongs_to :models
    has_one :service_details
end
Class Service_detail
    belgongs_to :service_executions
end

M * - * SE 1 - 1 SE

--------------

Class Models(USERS - Employee)
    has_many :user_service_executions
    has_many :service_executions, through: :User_service_executions
end
Class User_service_execution
    belongs_to :models
    belongs_to :service_executions
end
Class Service_execution
    has_many :user_service_executions
    has_many :models, through: :User_service_executions
end

USE * - * SE * - * M * - USE

--------------

Class Models(USERS - Client)
    has_many :service_requests
end
Class Service_request
    has_one :user_service_execution
    belongs_to :models
end
Class user_service_execution
    belongs_to :service_requests
end

M 1 - * SR 1 - 1 USE

--------------

> > > DB LOGIC


USE.profit =  SD.price - SE.value_charged  

single table inheritance



>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Para criar uma pagina que nao precisa criar tabela no banco

executar
  rails g controller reports index
editar routes.rb e excluir
  get 'reports/index'
editar routes.rb e adicionar
  get 'reports', to: 'reports#index'

editar layouts/_navigation.html.erb e criar o novo item no menu
  <a class="dropdown-item" href=<%=reports_path%>>Lista de transações por cliente</a>

