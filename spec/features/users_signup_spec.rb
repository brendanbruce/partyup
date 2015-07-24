require "spec_helper"

feature "User signs up for a new account" do
  scenario "they sign up with invalid information" do
    visit "users/signup"

    fill_in "name", with: "Brendan"
    fill_in "email", with: "bb@b"
    fill_in "password", with: "buddybuddy"
    fill_in "password_confirmation", with: "buddybuddy"

    click_button "Create my Account"

    expect(page).to have_css "error_explanation"
  end
end
