class Comment < ActiveRecord::Base
  attr_accessible :content, :mark

  belongs_to :user
  belongs_to :script

  validates :content, :mark, :presence => true
  validates_inclusion_of :mark, :in => 1..6, :message => "kann nur eine Zahl zwischen 1 und 6 sein."

  def self.create_comment params, script, current_user
    comment = Comment.new
    comment.content= params[:comment][:content]
    comment.mark= params[:comment][:mark]
    comment.script= script
    comment.user= current_user
    comment
  end
end
