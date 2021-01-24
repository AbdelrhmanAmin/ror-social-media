require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    user = User.create(name: 'Abdo', email: 'Abdo34@yahoo.com', password: '123456')
    p = Post.create(content: 'Post description', user_id: user.id)
    it 'should have a post ' do
      expect(Post.new).to_not be_valid
    end
    it 'valid ' do
      expect(p).to be_valid
    end
  end
end
