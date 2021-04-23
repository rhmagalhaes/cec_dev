require "application_system_test_case"

class UnitsTest < ApplicationSystemTestCase
  setup do
    @unit = units(:one)
  end

  test "visiting the index" do
    visit units_url
    assert_selector "h1", text: "Units"
  end

  test "creating a Unit" do
    visit units_url
    click_on "New Unit"

    fill_in "Ac filter size", with: @unit.AC_filter_size
    fill_in "Address", with: @unit.address
    fill_in "Bathrooms", with: @unit.bathrooms
    fill_in "Bedrooms", with: @unit.bedrooms
    fill_in "Building name", with: @unit.building_name
    fill_in "Contact email", with: @unit.contact_email
    fill_in "Contact name", with: @unit.contact_name
    fill_in "Contact phone", with: @unit.contact_phone
    fill_in "Windows", with: @unit.windows
    click_on "Create Unit"

    assert_text "Unit was successfully created"
    click_on "Back"
  end

  test "updating a Unit" do
    visit units_url
    click_on "Edit", match: :first

    fill_in "Ac filter size", with: @unit.AC_filter_size
    fill_in "Address", with: @unit.address
    fill_in "Bathrooms", with: @unit.bathrooms
    fill_in "Bedrooms", with: @unit.bedrooms
    fill_in "Building name", with: @unit.building_name
    fill_in "Contact email", with: @unit.contact_email
    fill_in "Contact name", with: @unit.contact_name
    fill_in "Contact phone", with: @unit.contact_phone
    fill_in "Windows", with: @unit.windows
    click_on "Update Unit"

    assert_text "Unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Unit" do
    visit units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Unit was successfully destroyed"
  end
end
