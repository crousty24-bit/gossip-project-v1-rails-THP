class RemoveCityFromGossips < ActiveRecord::Migration[8.0]
  def change
    remove_reference :gossips, :city, null: false, foreign_key: true
  end
end
