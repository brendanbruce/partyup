require "rails_helper"

feature "User signs in" do
  scenario "with valid credentials" do
    visit login_path

    user = FactoryGirl.create(:user)

    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password

    click_button "Log In"

    within(:css, "div.user-profile__info") do
      expect(page).to have_content(user.name)
    end
  end

  scenario "with invalid credentials" do
    visit login_path

    fill_in "session_email", with: "axlablack@a.co"
    fill_in "session_password", with: "axaxkakjklajdlkgja"

    click_button "Log In"
    expect(page).to have_content("Invalid email/password combination")
  end
end
