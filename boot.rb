require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'csv'

require_relative 'import_export'
require_relative 'models/employee'
require_relative 'reports/structure_report'

I18n.enforce_available_locales = false 

def set_up_active_record
  ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: ":memory:"
  )

  ActiveRecord::Schema.verbose = false
  ActiveRecord::Schema.define do
    create_table :employees do |table|
      table.column :name, :string
      table.column :manager, :string
      table.column :department, :string
      table.column :salary, :currency
    end
  end  
end

set_up_active_record


