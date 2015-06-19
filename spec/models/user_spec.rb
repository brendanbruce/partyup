require "test_helper"

describe User do
  before :each do
    @user = User.new(name: "Testy Test", email: "test@example.com")
  end

  describe "#new" do
    it "takes two parameters and returns a user" do
      @user.should be_an_instance_of User
    end
  end
end
