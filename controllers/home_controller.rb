class HomeController < Controller
  around_filter :layout
  before_filter :header
  after_filter :footer
  
  def index
    @message = "This class is uber awesome! :p"
    render :index
  end
  
  def nice
    response.write "This is nice!"
  end
  
  def header
    response.write "<h1>My App</h1>"
  end
  
  def footer
    response.write "<p>&copy; me</p>"
  end
  
  def layout
    response.write "<html><body>"
    yield
    response.write "</body></html>"
  end
end