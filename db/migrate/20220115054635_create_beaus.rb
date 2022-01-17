class CreateBeaus < ActiveRecord::Migration[7.0]
  def change
    create_table :beaus do |t|
      t.text :svg
      t.string :signature
      t.text :stats

      t.timestamps
    end
  end
end
