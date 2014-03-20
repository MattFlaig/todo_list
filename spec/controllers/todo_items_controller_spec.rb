require 'spec_helper'

describe TodoItemsController do

  
  describe "GET index" do
    it "sets @todo_items to the todo items of the current user" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      todo_item1 = Fabricate(:todo_item, user: amanda)
      todo_item2 = Fabricate(:todo_item, user: amanda)
      get :index
      expect(assigns(:todo_items)).to match_array([todo_item1, todo_item2])
    end
    
    it_behaves_like "requires login" do
      let(:action) { get :index }
    end
      
  end

  describe "GET show" do
    it_behaves_like "requires login" do
      let(:action) { get :show, id: 2}
    end    

    it "sets @todo_item to the todo item of the current user" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      todo_item = Fabricate(:todo_item, user: amanda)
      get :show, id: todo_item.id
      expect(assigns(:todo_item)).to eq(todo_item)
    end
  end

  describe "GET new" do
    it_behaves_like "requires login" do
      let(:action) { get :new}
    end  

    it "sets @todo_item to be an instance of the current user's todo items" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      get :new
      expect(assigns(:todo_item)).to be_instance_of(TodoItem)
    end
  end

  describe "POST create" do 
    

    context "with valid input" do
      before do
        amanda = Fabricate(:user)
        set_current_user(amanda)
        post :create, todo_item: Fabricate.attributes_for(:todo_item), user_id: amanda.id
      end

    it_behaves_like "requires login" do
      let(:action) { post :create, user_id: 1}
    end 

    it "creates a todo item for the current user" do
      expect(TodoItem.count).to eq(1)
    end
        
    it "sets a flash notice that todo item was created" do
      expect(flash[:notice]).not_to be_empty
    end

    it "redirects to index" do
      expect(response).to redirect_to todo_items_path
    end

    end

    context "with invalid input" do
      before do
        amanda = Fabricate(:user)
        set_current_user(amanda)
        invalid = TodoItem.create(name: "invalid")
        post :create, todo_item: {name: invalid.name, user_id: amanda.id}
      end

      it "does not create the todo item" do
        expect(TodoItem.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template 'new'
      end

    end
  end

  describe "PUT update" do
    context "with valid input" do
      before do
        amanda = Fabricate(:user)
        set_current_user(amanda)
        todo_item = Fabricate(:todo_item, user_id: amanda.id)
        put :update, {id: todo_item.id, todo_item: {name: "More todo"}}
      end

      it_behaves_like "requires login" do
        let(:action) { put :update, id: 1 }
      end

      it "updates the todo item" do
        expect(TodoItem.first.name).to eq("More todo")
      end

      it "sets a flash notice that the todo item has been updated" do
        expect(flash[:notice]).not_to be_empty
      end

      it "redirects to index" do
        expect(response).to redirect_to todo_items_path
      end
    end

    context "with invalid input" do
      before do
        amanda = Fabricate(:user)
        set_current_user(amanda)
        todo_item = Fabricate(:todo_item, user_id: amanda.id)
        put :update, {id: todo_item.id, todo_item: {name: " "}}
      end

      it_behaves_like "requires login" do
        let(:action) { put :update, id: 1 }
      end

      it "does not update the todo item" do
        expect(TodoItem.first.name).not_to be_blank
      end
        
        
      it "renders the edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST done" do
    before do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      todo_item = Fabricate(:todo_item, user_id: amanda.id)
      post :done, {id: todo_item.id, todo_item: {status: 1}}
    end

    it_behaves_like "requires login" do
      let(:action) { post :done, id: 1 }
    end

    it "changes the status of the todo item from 0 to 1" do
      expect(TodoItem.first.status).to eq(1)
    end

    it "sets a message that the todo item is done" do
      expect(flash[:notice]).not_to be_empty
    end

    it "renders the show template of the done todo item" do
      expect(response).to render_template :show
    end

  end

  describe "DELETE destroy" do
    before do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      todo_item = Fabricate(:todo_item, user_id: amanda.id)
      delete :destroy, {id: todo_item.id}
    end
  
    it_behaves_like "requires login" do
      let(:action) { delete :destroy, id: 1 }
    end

    it "deletes the todo item" do
      expect(TodoItem.first).to be_nil
    end

    it "sets a notice that the todo item has been deleted" do
      expect(flash[:notice]).not_to be_empty
    end

    it "redirects to index" do
      expect(response).to redirect_to todo_items_path
    end
  end       
end