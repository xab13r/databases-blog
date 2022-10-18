require 'post_repository'

def reset_post_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_post_table
  end

  describe "#all" do
    it "returns an array of all Post objects" do
      repo = PostRepository.new
      
      all_posts = repo.all
      
      expect(all_posts.length).to eq 6
      expect(all_posts.first.id).to eq 1
      expect(all_posts.first.title).to eq 'post 1'
      expect(all_posts.first.content).to eq 'content 1'
      expect(all_posts.last.id).to eq 6
      expect(all_posts.last.title).to eq 'post 6'
      expect(all_posts.last.content).to eq 'content 6'
    end
  end
  
  describe "#find_with_comments" do
    it "returns a list of Comment objects given a Post ID" do
      repo = PostRepository.new
      
      post = repo.find_with_comments(1)
            
      expect(post.id).to eq 1
      expect(post.comments.length).to eq 3
    
    end
  end
end