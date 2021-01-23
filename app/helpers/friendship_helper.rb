# rubocop:disable Layout/LineLength
module FriendshipHelper
  def friendship_button(the_other_user)
    # already friends
    if current_user.friend?(the_other_user)
      'Already friends'
      # current user already sent a request
    elsif current_user.friend_requests.include?(the_other_user)
      html = ''
      html << "<div>
              #{link_to('Accept',
                        accept_friendship_path(Friendship.where(user: the_other_user, friend: current_user).first), method: :post, class: 'btn btn-success')}
              #{link_to('Reject',
                        reject_friendship_path(Friendship.where(user: the_other_user, friend: current_user).first), method: :post, class: 'btn btn-danger')}
          </div>"
      html.html_safe
      # not friends
    elsif !current_user.friend?(the_other_user) && current_user != the_other_user && !current_user.friend_requests.include?(the_other_user) && !current_user.pending_friends.include?(the_other_user)
      render 'friendship/form', user: the_other_user
    end
  end
end
# rubocop:enable Layout/LineLength
