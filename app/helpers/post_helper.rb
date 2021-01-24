module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def display_posts(posts)
    out = ''
    posts.each do |post|
      next unless current_user.friend?(User.find(post.user_id)) || current_user == User.find(post.user_id)

      out << "
            <li class='post'>
            <div>
              <div class='post-attribution' >
                #{link_to post.user.name, user_path(post.user), class: 'post-author'}
              </div>
              <div class='post-liking'>
                #{ if current_user == post.user
                     button_to 'Delete', post_path(post.id), method: :post, class: 'btn btn-outline-danger'
                   end}
                <span class='text-warning'>
                #{Like.all.where(post_id: post.id).count}
                have liked this post!</span><br>
                #{like_or_dislike_btn(post)}
              </div>
            </div>
            <p class='post-content'>
               #{post.content}
            </p>

            <div class='post-comments-section'>
                <span class='text-warning'>
                #{Comment.all.where(post_id: post.id).count} have commented!</span><br>
                #{render partial: 'comments/comment', collection: post.comments}
              #{form_for(post.comments.new, url: post_comments_path(post)) do |form|
                  test = ''
                  test <<
                  "
                    #{form.text_field :content, id: :comment_content, class: 'form-control',
                                                placeholder: 'Add new Comment'}
                    #{form.submit 'Comment', class: 'btn btn-secondary'}
                    "
                  test.html_safe
                end}
                </div>
                <hr class='hr py-3 w-100'>
          </li>
        "
    end
    out.html_safe
  end

  def del_btn(user, comment)
    out = ''
    if current_user == user
      out <<
        "<div class=' d-flex justify-content-end w-50'>
          #{button_to 'Delete', post_comment_path(comment.post_id, comment.id), method: :post,
                                                                                class: 'btn btn-outline-danger'}
        </div>"
    end
    out.html_safe
  end
end
