class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :commentsCounter
      t.integer :likesCounter
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
