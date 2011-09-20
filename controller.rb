require "filters"

class Controller
  attr_accessor :request, :response
  
  include Filters
  
  def render(action)
    response.write render_to_string(action)
  end
  
  def render_to_string(action)
    path = template_path(action)
    # binding holds the current context of execution.
    ERB.new(File.read(path)).result(binding)
  end
  
  def template_path(action)
    File.dirname(__FILE__) + "/views/#{controller_name}/#{action}.erb"
  end
  
  def controller_name
    self.class.name[/(\w+)Controller$/, 1].downcase
  end
end