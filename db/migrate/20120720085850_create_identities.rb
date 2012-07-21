class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :password_digest
      t.string :username, :unique => true
      t.string :email, :unique => true

      t.timestamps
    end
  end
end
