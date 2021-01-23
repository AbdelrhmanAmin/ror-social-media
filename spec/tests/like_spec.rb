require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid if all the fields are provided' do
    user = User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Like.create(post_id: post.id, user_id: user.id)).to be_valid
  end

  it 'User must exist' do
    user = User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    post = Post.create(content: 'Post description', user_id: user.id)
    expect(Like.create(post_id: post.id)).not_to be_valid
  end

  it 'Post must exist' do
    user = User.create(name: 'Abdo', email: 'Abdo@yahoo.com', password: '123456')
    expect(Like.create(user_id: user.id)).not_to be_valid
  end
end
