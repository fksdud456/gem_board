class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :post_id	# Foreign key
      t.timestamps null: false
    end
  end
end
