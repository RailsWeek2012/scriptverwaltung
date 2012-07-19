class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.string :name
      t.string :dozent
      t.string :kurs
      t.string :fachrichtung
      t.string :hochschule
      t.text :beschreibung
      t.date :erscheinungsdatum

      t.timestamps
    end
  end
end
