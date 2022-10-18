require_relative 'lib/database_connection'
require_relative 'lib/post_repository'
require_relative 'lib/comment_repository'

class Application
  def initialize(database_name, io, post_repository, comment_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
    @comment_repository = comment_repository
  end

  def run
    @io.puts('Here is a list of your posts ([id] - [title])')

    all_post = @post_repository.all

    all_post.each do |post|
      @io.puts("#{post.id} - #{post.title}")
    end

    @io.puts('Choose the post you want to inspect:')
    choice = @io.gets.chomp

    post = @post_repository.find_with_comments(choice)

    @io.puts "\nTitle: #{post.title}"
    @io.puts "Content: #{post.content}"
    post.comments.each do |comment|
      @io.puts "\t#{comment.author_name}: #{comment.content}"
    end
  end
end
