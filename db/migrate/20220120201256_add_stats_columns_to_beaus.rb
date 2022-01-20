class AddStatsColumnsToBeaus < ActiveRecord::Migration[7.0]
  def change
    add_column :beaus, :population, :integer
    add_column :beaus, :density, :string
    add_column :beaus, :aura, :string
    add_column :beaus, :energy, :string

    remove_column :beaus, :stats
  end
end
