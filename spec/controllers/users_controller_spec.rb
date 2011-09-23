require 'spec_helper'

describe UsersController do
  # Have to add this so rspec will actually go to the page
  render_views

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
