require "rails_helper"

describe User do
  before :each do
    @user = User.new(name: "Testy Test", email: "test@example.com", password: "fooobarr", password_confirmation: "fooobarr")
  end

  describe "#new" do
    it "takes two parameters and returns a user" do
      expect(@user).to be_an_instance_of User
    end

    it "should have name be present" do
      @user.name = " "
      expect(@user).to_not be_valid
    end

    it "should have email be present" do
      @user.email = " "
      expect(@user).to_not be_valid
    end

    it "should have name less than 51 characters" do
      @user.name = "a" * 51
      expect(@user).to_not be_valid
    end

    it "should have email less than 255 characters" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user).to_not be_valid
    end

    it "should have properly formatted email address" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
      end
    end

    it "should reject invalid email addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org
                            user.name@example. foo@bar_baz.com foo@bar+baz.com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid, "#{invalid_address.inspect} should be valid"
      end
    end

    it "should reject duplicate email addresses" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to_not be_valid
    end

    it "should have a non blank password" do
      @user.password = @user.password_confirmation = " " * 8
      expect(@user).to_not be_valid
    end

    it "should have a non blank password" do
      @user.password = @user.password_confirmation = "a" * 7
      expect(@user).to_not be_valid
    end
  end
end
