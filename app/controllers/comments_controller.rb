class CommentsController < ApplicationController
  before_filter :require_login!
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new
    @comment.content= params[:comment][:content]
    @comment.mark= params[:comment][:mark]
    sc = Script.find(params[:comment][:script])
    @comment.script= sc
    @comment.user= current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to sc , notice: 'Kommentar wurde erfolgreich erzeugt' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
