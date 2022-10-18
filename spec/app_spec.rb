require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do
    reset_tables
  end

  describe '#run' do
    it 'prints out the data of one post with its comments' do
      io = double(:io)
      database = 'blog_test'
      post_repository = double(:post_repository)
      comment_repository = double(:comment_repository)

      comment_1 = double(:comment, id: 1, content: 'comment 1', author_name: 'user 2')

      post_1 = double(:post_1, id: 1, title: 'title 1', content: 'content 1', comments: [comment_1])
      post_2 = double(:post_2, id: 2, title: 'title 2', content: 'content 2')

      application = Application.new(database, io, post_repository, comment_repository)

      expect(io).to receive(:puts).with('Here is a list of your posts ([id] - [title])')
      expect(post_repository).to receive(:all).and_return([post_1, post_2])
      expect(io).to receive(:puts).with("#{post_1.id} - #{post_1.title}")
      expect(io).to receive(:puts).with("#{post_2.id} - #{post_2.title}")
      expect(io).to receive(:puts).with('Choose the post you want to inspect:')
      expect(io).to receive(:gets).and_return('1')
      expect(post_repository).to receive(:find_with_comments).with('1').and_return(post_1)
      expect(io).to receive(:puts).with("\nTitle: #{post_1.title}")
      expect(io).to receive(:puts).with("Content: #{post_1.content}")
      expect(io).to receive(:puts).with("\t#{comment_1.author_name}: #{comment_1.content}")
      application.run
    end
  end
end
