# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module FriendshipHelper
  def friendship_button(the_other_user)
    # already friends
    if current_user.friend?(the_other_user)
      if Friendship.where(user: the_other_user, friend: current_user).first.nil?
        path = Friendship.where(user: current_user, friend: the_other_user ).first
      else
        path = Friendship.where(user: the_other_user, friend: current_user).first
      end
      html = ''
      html << "<div>
      #{link_to('Unfriend', friendship_path(path),
                method: :post, class: 'btn btn-danger')}
      </div>"
      html.html_safe
      # current user already sent a request
    elsif current_user.friend_requests.include?(the_other_user)
      html = ''
      html << "<div>
      #{link_to('Accept', accept_friendship_path(
                            Friendship.where(user: the_other_user, friend: current_user).first
                          ),
                method: :post, class: 'btn btn-success')}
      #{link_to('Reject', reject_friendship_path(Friendship.where(user: the_other_user,
                                                                  friend: current_user).first),
                method: :post, class: 'btn btn-danger')}
      </div>"
      html.html_safe
      # not friends
    elsif !current_user.friend?(the_other_user) &&
          current_user != the_other_user &&
          !current_user.friend_requests.include?(the_other_user) &&
          !current_user.pending_friends.include?(the_other_user)
      render 'friendship/form', user: the_other_user
    elsif current_user != the_other_user
      'Pending'  
    elsif current_user == the_other_user
       image_tag 'https://i.pinimg.com/564x/50/47/85/504785e9f6ad90daef358927f555f526.jpg', size: "100x100"

    end
  end
  def display_friends(user)
    out = ''
    user.friends.each do |i|
      out << "
        <li>  
          #{i.name}
        </li>
      "
    end
    out.html_safe
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
