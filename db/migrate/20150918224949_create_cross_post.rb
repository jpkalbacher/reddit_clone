class CreateCrossPost < ActiveRecord::Migration
  def change
    create_table :cross_posts do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false
    end

    add_index :cross_posts, [:post_id, :sub_id], unique: true
    add_index :cross_posts, :sub_id, unique: true
  end
end
