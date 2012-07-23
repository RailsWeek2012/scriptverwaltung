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
end
