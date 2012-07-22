class Script < ActiveRecord::Base
  attr_accessible :beschreibung, :dozent, :erscheinungsdatum, :fachrichtung, :hochschule, :kurs, :name, :upload

  has_attached_file :upload,
                    :path => ":rails_root/uploaded_scripts/:id-:basename.:extension"

  validates_attachment_presence :upload
  validates_attachment_size :upload, less_than: 5.megabytes
  validates_attachment_content_type :upload, content_type: ['image/jpeg', 'application/pdf', 'application/x-pdf', 'application/binary']   #Kleiner Workaround für den FF, der schickt pdf mit application/binary unter Linux
  validates_format_of :upload_file_name, with: %r{\.(pdf|jpg|jepg)$}i #Validierung des Dateinamen wegen des Workarounds.

end