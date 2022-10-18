require 'comment_repository'

def reset_comment_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

describe CommentRepository do
  before(:each) do 
    reset_comment_table
  end

  # (your tests will go here).
end