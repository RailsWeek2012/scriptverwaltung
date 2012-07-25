#encoding: utf-8
module ScriptsHelper
  #komplett übernommen aus http://stackoverflow.com/questions/2143300/protecting-the-content-of-public-in-a-rails-app
  def send_file(filepath, options = {})
    options[:content_type] ||= "application/force-download"
    response.headers['Content-Type'] = options[:content_type]
    response.headers['Content-Disposition'] = "attachment; filename=\"#{File.basename(filepath)}\""
    response.headers['X-Sendfile'] = filepath
    response.headers['Content-length'] = File.size(filepath)
    render :nothing => true
  end
end
