#Encoding: utf-8
class ScriptsController < ApplicationController
  before_filter :require_login!, :except => [ :show, :index, :download ]
  before_filter :only_owner!, :only => [:edit, :update, :destroy]
  before_filter :isVisible?, :only => [:show]
  # GET /scripts
  # GET /scripts.json

  def index
    @scripts = Script.search(params[:search])
    store_return_url
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scripts }
    end
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    @script = Script.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @script }
      end
  end

  # GET /scripts/new
  # GET /scripts/new.json
  def new
    @script = Script.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/1/edit
  def edit
    @script = Script.find(params[:id])
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = Script.new(params[:script])
    @script.user= User.find(session[:user_id])
    respond_to do |format|
      if @script.save
        format.html { redirect_to @script, notice: 'Script wurde angelegt' }
        format.json { render json: @script, status: :created, location: @script }
      else
        format.html { render action: "new" }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scripts/1
  # PUT /scripts/1.json
  def update
    @script = Script.find(params[:id])
      respond_to do |format|
        if @script.update_attributes(params[:script])
          format.html { redirect_to @script, notice: 'Script wurde geändert.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @script.errors, status: :unprocessable_entity }
        end
      end
  end


  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    @script = Script.find(params[:id])
        @script.destroy
        respond_to do |format|
          format.html { redirect_to scripts_url }
          format.json { head :no_content }
        end
  end

  def download
    if script_activated?
      @script = Script.find(params[:id])
      send_file @script.upload.path , :content_type =>  @script.upload.content_type
    else
      redirect_to scripts_path, :alert => "Das Script ist noch nicht freigeschaltet oder existiert nicht"
    end
  end

  def makeActiv
    if isAdmin?
      @script = Script.find(params[:id])
      @script.activated= true
      @script.save
    end
    redirect_back_or_default(show_user_path(current_user))
  end

  private
    def script_activated?
      @script = Script.find(params[:id])
      unless @script.nil?
        return (@script.user == current_user or isAdmin?)
      end
      false
    end

end
