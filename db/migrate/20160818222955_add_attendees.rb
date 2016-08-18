class AddAttendees < ActiveRecord::Migration
  def change
  	create_join_table :events, :users, table_name: :attended
  end
end
