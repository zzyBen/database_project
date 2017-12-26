require 'rails_helper'
require 'support/utilities'



describe "User pages" do
  
  subject { page }
  
  shared_examples_for "all user pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end
  
  describe "index" do
=begin
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end #before
=end
    let(:user) { FactoryGirl.create(:user) }
    
#    before(:each) do
    before do
      sign_in user
      visit users_path
    end
    
    it { should have_title('All users') }
    it { should have_content('All users') }
    
    describe "pagination" do
    
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }
      
      it { should have_selector('div.pagination') }
    
      it "should list each user" do
        #User.all.each do |user|
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end # pagination
    
    describe "delete links" do
      
      it { should_not have_link('delete') }
      
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        
        it { should have_link('delete', href: user_path(User.first)) }
        
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end # as an admin user
    
    end # delete links
    
  end # index
   
   
  describe "profile page" do
    #Replace with code to make a user variable
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
    
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end # microposts
  end # profile page
  
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
    end # with invalid information
    
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
        
        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'successfully') }
      end
    end # with valid information
    
    
    describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit edit_user_path(user)
      end
      
      describe "page" do
        it { should have_content("Update your profile") }
        it { should have_title("Edit user") }
        it { should have_link('change', href: 'http://gravatar.com/emails') }
      end # page
    
      
      describe "with invalid information" do
        before { click_button "Save changes" }
        
        it { should have_content('error') }
      end # with invalid information
      
      
      describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end # before
        
        it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        it { expect(user.reload.name).to    eq new_name }
        it { expect(user.reload.email).to   eq new_email }
      end # with valid information
    
    
      describe "forbidden attributes" do
        let(:params) do { user: { admin: true, password: user.password, password_confirmation: user.password } } end

        
        #before { patch user_path(user), params }
        it { expect(user.reload).not_to be_admin }        
      end # forbidden attributes
    end # edit
  
    
  end # signup
  


end # User pages
