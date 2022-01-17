class AddBackgroundToBeau < ActiveRecord::Migration[7.0]
  def change
    add_column :beaus, :background_color, :string
  end
end
