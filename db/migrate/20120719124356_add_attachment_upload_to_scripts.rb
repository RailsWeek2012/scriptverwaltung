class AddAttachmentUploadToScripts < ActiveRecord::Migration
  def self.up
    change_table :scripts do |t|
      t.has_attached_file :upload
    end
  end

  def self.down
    drop_attached_file :scripts, :upload
  end
end
