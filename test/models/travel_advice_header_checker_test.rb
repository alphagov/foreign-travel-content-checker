# frozen_string_literal: true

require "test_helper"

class TravelAdviceHeaderCheckerTest < ActiveSupport::TestCase
  include ForeignTravelAdviceApiHelper

  setup do
    stub_foreign_travel_advice_api
    @header_checker = TravelAdviceHeaderChecker.new("spain")
  end

  test "returns a hash of each country with thier header status" do
    expected = [
      {
        "slug" => "france",
        "name" => "France",
        "all_travellers" => true,
        "transiting" => true,
        "not_fully_vaccinated" => true,
        "fully_vaccinated" => true,
        "children_young" => true,
        "exemptions" => true,
      },
      {
        "slug" => "germany",
        "name" => "Germany",
        "all_travellers" => true,
        "transiting" => true,
        "not_fully_vaccinated" => true,
        "fully_vaccinated" => true,
        "children_young" => true,
        "exemptions" => true,
      },
      {
        "slug" => "spain",
        "name" => "Spain",
        "all_travellers" => true,
        "transiting" => true,
        "not_fully_vaccinated" => true,
        "fully_vaccinated" => true,
        "children_young" => true,
        "exemptions" => true,
      },
    ]

    assert_equal expected, TravelAdviceHeaderChecker.countries_header_status
  end

  test "returns all countries in a hash" do
    expected = {
      "france" => "France",
      "germany" => "Germany",
      "spain" => "Spain",
    }

    assert_equal expected, TravelAdviceHeaderChecker.countries
  end

  test "should handle connection timeouts" do
    stub_request(:get, "https://www.gov.uk/api/content/foreign-travel-advice").with(
      headers: { "Content-Type" => "application/json" },
    ).to_timeout

    assert_raises(StandardError) do
      TravelAdviceHeaderChecker.countries
    end
  end

  test "returns a hash containing the country content for all of the required headers" do
    expected = {
      "all-travellers" => "<p>Content</p>",
      "if-youre-transiting-through-spain" => "<p>Content</p>",
      "if-youre-not-fully-vaccinated" => "<p>Content</p>",
      "if-youre-fully-vaccinated" => "<p>Content</p>",
      "children-and-young-people" => "<p>Content</p>",
      "exemptions" => "<p>Content</p>",
    }

    assert_equal expected, @header_checker.content
  end

  test "returns true when country has all of the required headers" do
    assert_equal true, @header_checker.content_headers?
  end

  test "returns false when country does not have all of the required headers" do
    response = {
      details: {
        parts: [
          {
            body: '<h2 id="all-travellers">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-transiting-through-spain">Header</h2><p>Content</p>' \
              '<h2 id="children-and-young-people">Header</h2><p>Content</p>',
            slug: "entry-requirements",
          },
        ],
      },
    }.to_json

    stub_request(:get, "https://www.gov.uk/api/content/foreign-travel-advice/spain").with(
      headers: { "Content-Type" => "application/json" },
    ).to_return(status: 200, body: response)

    assert_equal false, @header_checker.content_headers?
  end
end
