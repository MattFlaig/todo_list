require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "saves the user to the database" do
        expect(User.count).to eq(1)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).not_to be_blank
      end

      it "redirects to login" do
        expect(response).to redirect_to login_path
      end
    end
  
    context "with invalid input" do
      it "does not save the user to the database" do
        post :create, user: {email: "user@user.com"}
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        post :create, user: {email: "user@user.com"}
        expect(response).to render_template :new
      end
    end
  end
end