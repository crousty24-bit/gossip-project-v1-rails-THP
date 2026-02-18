class AddCityToGossips < ActiveRecord::Migration[8.0]
  def change
    add_reference :gossips, :city, null: false, foreign_key: true
  end
end
