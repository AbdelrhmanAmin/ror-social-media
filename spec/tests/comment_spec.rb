require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid if all the fields are provided' do
    user = User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Comment.create(content: 'Comment content', user_id: user.id, post_id: post.id)).to be_valid
  end

  it 'User must exist' do
    user = User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Comment.create(content: 'Comment content', post_id: post.id)).not_to be_valid
  end
end