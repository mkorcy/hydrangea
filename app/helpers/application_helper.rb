module ApplicationHelper

  require_dependency 'vendor/plugins/blacklight/app/helpers/application_helper.rb'
  require_dependency 'vendor/plugins/hydra_repository/app/helpers/application_helper.rb'

  #copied these two method sfrom generic_content_objects_helper.rb

  def application_name
    'Hydrangea'
  end

  def disseminator_link pid, datastream_name
    "<a class=\"fbImage\" href=\"#{ datastream_disseminator_url(pid, datastream_name) }\">view</a>"
  end

   def datastream_disseminator_url pid, datastream_name
    begin
      base_url = Fedora::Repository.instance.send(:connection).site.to_s
    rescue
      base_url = "http://localhost:8983/fedora"
    end
    "#{base_url}/get/#{pid}/#{datastream_name}"
   end

  def get_google_docs_iframe pid, datastream_name
    "<iframe src=\"http://docs.google.com/viewer?url=#{ datastream_disseminator_url(pid, datastream_name)}&embedded=true\" width=\"600\" height=\"780\" style=\"border: none;\"></iframe>"
  end
end
