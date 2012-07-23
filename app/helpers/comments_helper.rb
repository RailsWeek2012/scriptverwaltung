module CommentsHelper
  def create_comment
    sc = Script.find(params[:comment][:script])
    if sc
      @comment= Comment.new
      @comment.content= params[:comment][:content]
      @comment.mark= params[:comment][:mark]
      @comment.script= sc
      @comment.user= current_user
    else
      redirect_to script_path, alert: "Es konnte kein valides Script gefunden werden."
    end
  end
end
