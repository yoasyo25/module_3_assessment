require "rails_helper"

feature "User searches for bestbuy stores" do
  it "finds stores within 25 mile radius" do

    visit "/"
    fill_in "search", with: 80202
    click_on "Search"

    expect(current_path).to eq("/search")

    expect(page).to have_content("17 Total Stores")

    within(first(".stores")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".city")
      expect(page).to have_css(".distance")
      expect(page).to have_css(".phone_number")
      expect(page).to have_css(".store_type")
    end
  end
end
