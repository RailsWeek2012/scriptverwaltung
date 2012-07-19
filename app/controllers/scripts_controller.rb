class ScriptsController < ApplicationController
  # GET /scripts
  # GET /scripts.json
  def index
    @scripts = Script.all

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

    respond_to do |format|
      if @script.save
        format.html { redirect_to @script, notice: 'Script was successfully created.' }
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
        format.html { redirect_to @script, notice: 'Script was successfully updated.' }
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
end
