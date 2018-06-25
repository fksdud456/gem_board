# 의식의 흐름

### Post 

- posts 컨트롤러 `rails g controller posts index new create show edit update destroy`
- post 모델 `rails g model post title:string content:text`



#### Comment

- comments 컨트롤러 `rails g controller comments index new create`
- comment 모델 `rails g model comment content:string `





### 자주쓰이는 함수 정의

```ruby
# posts_controller.rb
before_action : set_post, only:[:show, :edit, :update, :destroy]


private
def set_post
    @post = Post.find(params[:id])
end

```



### main page 

```ruby
# index.html.erb
```



### new

```erb
<!-- new.html.erb -->
```



### Create

```ruby
def create 
    @post = Post.new(post_params)
    @post.save
    redirect_to "/"
end

def post_params
    params.permit(:title, :content)
end
```



### ... post CRUD 완성



### post-comment Relation 정의

```ruby
# app/models/comment.rb
class Comment < ActiveRecord::Base
  belongs_to :post
end

# app/models/post.rb
class Post < ActiveRecord::Base
  has_many :comments
end

# db/migrate/2018..._create_comments
...
    create_table :comments do |t|
      ...
      t.integer :post_id	# Foreign key
      ...   		
...
```



### 댓글 등록 form

게시글 보는 페이지에서 댓글을 바로 등록할 수 있도록 같은 페이지

```erb
<!-- app/views/posts/show.html.erb -->

<div>
  <form action="posts/<%=@post.id%>/comments" method="post">
    <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
    <textarea name="content" rows="8" cols="80"></textarea>
    <input type="submit" name="" value="댓글등록">
  </form>
</div>
```

```ruby
# routes.rb

# post에 post_id를 가진 comment를 등록한다
post 'posts/:post_id/comments' => 'comments#create'
```



### Create

```ruby
# comments_controller.rb

def create 
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.save
    redirect_to "/posts/#{params[:id]}"
end

def comment_params
    params.permit(:content)
end
```



### Comment Show

```ruby
# posts_controller.rb 
# post에 1:N 으로 등록된 comments 를 보여주기 위해

def show
    @comments = @post.comments
end
```

