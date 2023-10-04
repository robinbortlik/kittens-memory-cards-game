module ApplicationHelper

  def avatar(game, user, class_names: "")
    image_tag "users/#{game.users.index(user)}.png", class: "w-12 h-12 " + class_names
  end
end
