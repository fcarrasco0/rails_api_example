class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string  :title
      t.text    :description
      t.string  :author
      t.string  :publisher
      t.string  :genre
      t.date    :release_date
      t.integer :edition

      t.timestamps
    end
  end
end
