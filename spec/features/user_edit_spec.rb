require "rails_helper"

feature "User edits profile" do
  scenario "they add invalid email" do
    user = FactoryGirl.create(:user)
    visit login_path

    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password

    click_button "Log In"

    visit edit_user_path(user.id)

    fill_in "user_name", with: user.name
    fill_in "user_email", with: "bb@b"
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password

    click_button "Update"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Email is invalid"
    end
  end

  scenario "they add invalid password" do
    user = FactoryGirl.create(:user)
    visit login_path

    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password

    click_button "Log In"

    visit edit_user_path(user.id)

    fill_in "user_name", with: user.name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "buddy"
    fill_in "user_password_confirmation", with: "buddy"

    click_button "Update"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Password is too short (minimum is 8 characters)"
    end
  end

  scenario "user updates profile successfully" do
    user = FactoryGirl.create(:user)
    visit login_path

    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password

    click_button "Log In"

    visit edit_user_path(user.id)

    fill_in "user_name", with: user.name
    fill_in "user_email", with: user.email

    click_button "Update"

    within(:css, ".alert") do
      expect(page).to have_content "Profile updated successfully"
    end
  end
end
