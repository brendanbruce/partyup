require "rails_helper"

def login_with_email(email: "brendan@skilledup.com")
  fill_in "user_name", with: "Brendan"
  fill_in "user_email", with: email
end

feature "User signs up for a new account" do
  scenario "they sign up with invalid email" do
    visit signup_path

    login_with_email(email: "b@bb")
    fill_in "user_password", with: "buddybuddy"
    fill_in "user_password_confirmation", with: "buddybuddy"

    click_button "Create my Account"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Email is invalid"
    end
  end

  scenario "they sign up with invalid password" do
    visit signup_path

    login_with_email
    fill_in "user_password", with: "buddy"
    fill_in "user_password_confirmation", with: "buddy"

    click_button "Create my Account"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Password is too short (minimum is 8 characters)"
    end
  end

  scenario "they sign up with unmatched password and password confirmation" do
    visit signup_path

    login_with_email
    fill_in "user_password", with: "buddybuddy"
    fill_in "user_password_confirmation", with: "buddyskater"

    click_button "Create my Account"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end

  scenario "they sign up with unmatched password and password confirmation and visit homepage" do
    visit signup_path

    login_with_email
    fill_in "user_password", with: "buddybuddy"
    fill_in "user_password_confirmation", with: "buddyskater"

    click_button "Create my Account"

    within(:css, "ul.error__list") do
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    click_link "Home"

    expect(page).to_not have_content "Password confirmation doesn't match Password"
  end
end
