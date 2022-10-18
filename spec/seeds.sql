TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES 
  ('post 1', 'content 1'),
  ('post 2', 'content 2'),
  ('post 3', 'content 3'),
  ('post 4', 'content 4'),
  ('post 5', 'content 5'),
  ('post 6', 'content 6');
  
INSERT INTO comments (content, author_name, post_id) VALUES 
  ('comment content 1', 'user 1', 1),
  ('comment content 2', 'user 2', 1),
  ('comment content 3', 'user 3', 1),
  ('comment content 4', 'user 1', 2),
  ('comment content 5', 'user 5', 3),
  ('comment content 6', 'user 6', 4),
  ('comment content 7', 'user 7', 5),
  ('comment content 8', 'user 4', 6),
  ('comment content 9', 'user 6', 6),
  ('comment content 10', 'user 7', 6);