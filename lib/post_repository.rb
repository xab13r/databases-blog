require_relative './post'

class PostRepository
  
  def record_to_post(record)
    post = Post.new
    post.id = record['id'].to_i
    post.title = record['title']
    post.content = record['content']
    return post
  end
  
  def all
    sql_query = 'SELECT * FROM posts;'
    result_set = DatabaseConnection.exec_params(sql_query, [])
    all_posts = result_set.map { |record| record_to_post(record) }
    
    if all_posts.empty?
      return false
    else
      return all_posts
    end
  end
end