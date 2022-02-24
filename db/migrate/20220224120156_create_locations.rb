# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :all_travellers, null: false, default: false
      t.boolean :transiting, null: false, default: false
      t.boolean :not_fully_vaccinated, null: false, default: false
      t.boolean :fully_vaccinated, null: false, default: false
      t.boolean :children_young, null: false, default: false
      t.boolean :exemptions, null: false, default: false

      t.timestamps
    end

    add_index :locations, :slug, unique: true
  end
end
