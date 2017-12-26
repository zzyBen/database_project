require 'rails_helper'
require 'support/utilities'

describe "Authentication" do

  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
  
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
  
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-danger') }
      end # after visiting another page
    end # with invalid information
    
    
    
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }     # spec/support/utilities
      
      it { should have_title(user.name) }
      it { should have_link('Users',        href: users_path) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Settings',     href: edit_user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should_not have_link('Sign in',  href: signin_path) }
    
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end # with valid information
    
  end # signin
  
  
  describe "authorization" do
  
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end # after signing in
      end # when attempting to visit a protected page
      
      describe "in the Users controller" do      
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end # visiting the edit page
      
        describe "submitting to the update action" do
          before { patch user_path(user) }
          it { expect(response).to redirect_to(signin_path) }
        end # submitting to the update action  
        
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end # visiting the user index
      end # in the Users controller
      
      
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          it { expect(response).to redirect_to(signin_path) }
        end # submitting to the create action
        
        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          it { expect(response).to redirect_to(signin_path) }
        end
      end # in the Microposts controller
    end # for non-signed-in users
  
  
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }
    
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit user')) }
      end # visiting User#edit page
      
      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        it { expect(response).to redirect_to(root_path) }
      end # submitting a PATCH request to the Users#update action    
    end # as wrong user
    
    
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin, no_capybara: true }
    
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        it { expect(response).to redirect_to(root_path) }
      end # submitting a DELETE request to the Users#destroy action
    end # as non-admin user
  
  
  end # authorization
  
  
end # Atuthentication
