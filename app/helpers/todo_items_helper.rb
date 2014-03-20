module TodoItemsHelper
  def back_to_todo_list
    content_tag(:p,
      link_to(t("links.back_to_todo_list"), todo_items_path),
      class: "btn btn-large btn-info")
  end
end
