class Comment < ActiveRecord::Base
  attr_accessible :content, :mark

  belongs_to :user
  belongs_to :script

  validates :content, :mark, :presence => true
  validates_inclusion_of :mark, :in => 1..6, :message => "kann nur eine Zahl zwischen 1 und 6 sein."
end
