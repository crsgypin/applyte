class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
    	t.integer :profile_id,:index=>true
    	t.integer :serial
    	t.string :title
    	t.string :url
      t.timestamps null: false
    end
  end
end
