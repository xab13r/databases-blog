require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('blog')

post_repository = PostRepository.new
comment_repository = CommentRepository.new

