require_relative './post'

class PostRepository
  def all
    sql_query = 'SELECT * FROM posts;'
    result_set = DatabaseConnection.exec_params(sql_query, [])
    all_posts = result_set.map { |record| record_to_post(record) }

    if all_posts.empty?
      false
    else
      all_posts
    end
  end

  def find_with_comments(id)
    sql_query = 'SELECT posts.id,
                        posts.title,
                        posts.content,
                        comments.id AS comment_id,
                        comments.content AS comment_content,
                        comments.author_name
                  FROM posts
                  JOIN comments ON posts.id = comments.post_id
                  WHERE posts.id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql_query, params)

    post = Post.new

    post.id = result.first['id'].to_i
    post.title = result.first['title']
    post.content = result.first['content']

    result.each do |record|
      post.comments.push(record_to_comment(record))
    end
    post
  end

  private

  def record_to_post(record)
    post = Post.new
    post.id = record['id'].to_i
    post.title = record['title']
    post.content = record['content']
    post
  end

  def record_to_comment(record)
    comment = Comment.new
    comment.id = record['comment_id'].to_i
    comment.content = record['comment_content']
    comment.author_name = record['author_name']
    comment.post_id = record['id'].to_i
    comment
  end
end
