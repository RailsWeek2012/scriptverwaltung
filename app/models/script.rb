class Script < ActiveRecord::Base
  attr_accessible :beschreibung, :dozent, :erscheinungsdatum, :fachrichtung, :hochschule, :kurs, :name, :upload
  has_attached_file :script


  has_attached_file :upload,
                    :url  => "/assets/scripts/:basename.:extension",
                    :path => ":rails_root/public/assets/scripts/:basename.:extension"

  validates_attachment_presence :upload
  validates_attachment_size :upload, :less_than => 5.megabytes
  validates_attachment_content_type :upload, :content_type => ['image/jpeg', 'application/pdf']

end