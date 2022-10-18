class Post
  attr_accessor :id, :title, :content, :comments
  
  def initialize
    @comments = Array.new
  end
end
  