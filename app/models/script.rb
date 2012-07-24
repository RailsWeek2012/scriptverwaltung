class Script < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :beschreibung, :dozent, :erscheinungsdatum, :fachrichtung, :hochschule, :kurs, :name, :upload

  has_attached_file :upload,
                    path: ":rails_root/uploaded_scripts/:id-:basename.:extension"
  validates :beschreibung, :dozent, :erscheinungsdatum, :fachrichtung, :hochschule, :kurs, :name, presence: true

  validates_attachment_presence :upload
  validates_attachment_size :upload, less_than: 25.megabytes
  validates_attachment_content_type :upload, content_type: ['application/pdf', 'application/x-pdf', 'application/binary']   #Kleiner Workaround für den FF, der schickt pdf mit application/binary unter Linux
  validates_format_of :upload_file_name, with: %r{\.(pdf)$}i #Validierung des Dateinamen wegen des Workarounds.


  def self.search(search)
  	if search
    	find(:all, :conditions => ['name LIKE ? or
    								dozent LIKE ? or
    								kurs LIKE ? or
    								fachrichtung LIKE ? or
    								hochschule LIKE ? or
    								beschreibung LIKE ?',
    								"%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
  	else
    	find(:all)
  	end
  end

  def average_mark
    comments = self.comments
    unless comments.isEmpty?
      sum = 0
      self.comments.each do |comment|
        sum += comment.mark
      end
      return sum / comments.count
    end
  end
end