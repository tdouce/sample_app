require 'spec_helper'

describe UsersController do
  # Have to add this so rspec will actually go to the page
  render_views
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory( :user )
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      # assigns(:user) returns teh value of teh instance variable
      # then verifies that the variable retrieved from teh database in the
      # action corresponds to the @user instance created by Factory Girl.
      assigns( :user ).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector( "title", :content => @user.name )
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector( "h1", :content => @user.name )
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector( "h1>img", :class => "gravatar")
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have a title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end

  end
end
