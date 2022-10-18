# Test-driving a Repository method with a JOIN

Based on this user stories:

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

- Test-drive and implement the three classes for the `posts` and `comments` tables.
- Write a small program in `app.rb` using the class `PostRepository` to print out the data of one post with its comments to the terminal.

- - - 

This is the SQL used for the tables:

```sql
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);

```