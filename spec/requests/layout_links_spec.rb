require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a Sign up page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign Up")
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign Up")
  end

  describe "when not signed in" do

    it "should have a sign in link" do
      visit root_path
      response.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
  end

  describe "when signed in" do

    before (:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
      #visit signin_path
      #fill_in :email, :with => @user.email
      #fill_in :password, :with => @user.password
      #click_button
    end

    it "should have a sign out link" do 
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end
  end

  describe "delete links" do

    it "shouldn't show for normal user" do
      @user = Factory(:user)
      integration_sign_in(@user)
      visit users_path
      response.should_not have_selector("a", :href => user_path(@user), :"data-method" => 'delete', :content => 'Delete')
    end

    it "should show for admin user" do
      @user = Factory(:user)
      admin = Factory(:user, :email => "admin@example.com", :admin => true)
      integration_sign_in(admin)
      visit users_path
      response.should have_selector("a", :href => user_path(@user), :"data-method" => 'delete', :content => 'Delete')
    end
  end

end
 