class CreateLogoSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :logo_settings do |t|
      t.string :setting_name, null: false
      t.text :setting_value
      t.timestamps
    end
    add_index :logo_settings, :setting_name, unique: true
  end
end
