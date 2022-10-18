require_relative './comment'

class CommentRepository
  def all
    sql_query = 'SELECT * FROM comments;'
    result_set = DatabaseConnection.exec_params(sql_query, [])

    result_set.map do |record|
      record_to_comment(record)
    end
  end

  private

  def record_to_comment(record)
    comment = Comment.new
    comment.id = record['comment_id'].to_i
    comment.content = record['comment_content']
    comment.author_name = record['author_name']
    comment.post_id = record['id'].to_i
  end
end
