#encoding: utf-8
class CommentsController < ApplicationController
  before_filter :require_login!
  # GET /comments/new
  # GET /comments/new.json
  def new
    @script = Script.find(params[:id])
    return if redirect_on_error(@script)
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @script = Script.find(params[:comment][:script])
    return if redirect_on_error(@script)

    @comment = Comment.create_comment(params, @script, current_user)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @script , notice: 'Bewertung wurde erfolgreich erzeugt' }
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
    if isAdmin? or isOwner?(@comment)
      @comment.destroy
      redirect_to @comment.script, notice: "Bewertung gelöscht"
    else
      redirect_to @comment.script, notice: "Sie können diese Bewertung nicht löschen"
    end
  end
  private
    def redirect_on_error script
      if redirect_to_scripts_because_script_is_deactivated(script) and redirect_to_script_because_comment_exists(script)
        return false
      end
      true
    end

    def redirect_to_script_because_comment_exists script
      unless script.comments.where(user_id: current_user.id).empty?
        redirect_to script, notice: "Sie dürfen ein Script nur einmal bewerten"
        return false
      end
      true
    end
    def redirect_to_scripts_because_script_is_deactivated script
      unless script.activated?
        redirect_to scripts_path, notice: "Sie können nur Bewertungen auf existierende/freigegebene Scripts erzeugen"
        return false
      end
      true
    end
  end

