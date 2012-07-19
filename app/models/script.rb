class Script < ActiveRecord::Base
  attr_accessible :beschreibung, :dozent, :erscheinungsdatum, :fachrichtung, :hochschule, :kurs, :name
end
