#encoding: utf-8
module ScriptsHelper
  def send_file(filepath, options = {})
    options[:content_type] ||= "application/force-download"
    response.headers['Content-Type'] = options[:content_type]
    response.headers['Content-Disposition'] = "attachment; filename=\"#{File.basename(filepath)}\""
    response.headers['X-Sendfile'] = filepath
    response.headers['Content-length'] = File.size(filepath)
    render :nothing => true
  end

  def isOwner? script
  	current_user == script.user
  end


    def require_login!
      unless user_signed_in?
        redirect_to login_path, alert: "Bitte melden Sie sich zuerst an."
      end
    end
    def only_owner!
      @script = Script.find(params[:id])
      unless current_user == @script.user || isAdmin?
        redirect_to scripts_path, alert: 'Sie haben keine Berechtigung die Ressource zu ändern'
      end
    end
end
