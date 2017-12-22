require 'rails_helper'
require 'support/utilities'



describe "User pages" do
  
  subject { page }
  
  shared_examples_for "all user pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end
   
   
  describe "profile page" do
    #Replace with code to make a user variable
    let(:user) {FactoryGirl.create(:user)}
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    let(:heading) { 'Sign up' }
    let(:page_title) {'Sign up'}
    it_should_behave_like "all user pages"
  end
  
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }
        
        let(:heading) { 'error' }
        let(:page_title) {'Sign up'}
        it_should_behave_like "all user pages"
        
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "user@example.com") }
        
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'successfully') }
      end
    end
  end
  


end
