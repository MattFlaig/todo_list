class TodoItemsController < ApplicationController
require 'pry'
before_action :require_login

def index
	@todo_items = current_user.todo_items
end

def show
  @todo_item = current_user.todo_items.find(params[:id])
  #binding.pry
end

def new
  @todo_item = current_user.todo_items.build
end

def create
  @todo_item = current_user.todo_items.build(todo_item_params)
  if @todo_item.save
    flash[:notice] = t("messages.new_todo_item")
    redirect_to todo_items_path
  else
    render 'new'
  end
end

def edit
  @todo_item = current_user.todo_items.find(params[:id])
end

def update
  @todo_item = current_user.todo_items.find(params[:id])
  if @todo_item.update_attributes(todo_item_params)
    flash[:notice] = t("messages.edit_todo_item")
    redirect_to todo_items_path
  else
    render 'edit'
  end
end

def done
  @todo_item = current_user.todo_items.find(params[:id])
  @todo_item.status = 1
  @todo_item.save
  flash[:notice] = t("messages.done")
  render 'show'
end

def destroy
  @todo_item = current_user.todo_items.find(params[:id])
  @todo_item.destroy
  flash[:notice] = t("messages.delete_todo_item")
  redirect_to todo_items_path
end

private

def require_login
  unless logged_in?
    flash[:danger] = t("messages.not_logged_in")
    redirect_to login_path
  end
end

def todo_item_params
  params.require(:todo_item).permit(:name, :content, :comment, :deadline, :status)
end

end
  

