# frozen_string_literal: true

module ForeignTravelAdviceApiHelper
  def stub_foreign_travel_advice_api
    all_countries_response = {
      links: {
        children: [
          { details: { country: { name: 'Spain', slug: 'spain' } } },
          { details: { country: { name: 'Germany', slug: 'germany' } } },
          { details: { country: { name: 'France', slug: 'france' } } }
        ]
      }
    }.to_json

    stub_request(:get, 'https://www.gov.uk/api/content/foreign-travel-advice').with(
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(status: 200, body: all_countries_response)

    spain_response = {
      details: {
        parts: [
          {
            body: '<h2 id="all-travellers">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-transiting-through-spain">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-not-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="children-and-young-people">Header</h2><p>Content</p>' \
              '<h2 id="exemptions">Header</h2><p>Content</p>',
            slug: 'entry-requirements'
          }
        ]
      }
    }.to_json

    france_response = {
      details: {
        parts: [
          {
            body: '<h2 id="all-travellers">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-transiting-through-france">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-not-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="children-and-young-people">Header</h2><p>Content</p>' \
              '<h2 id="exemptions">Header</h2><p>Content</p>',
            slug: 'entry-requirements'
          }
        ]
      }
    }.to_json

    germany_response = {
      details: {
        parts: [
          {
            body: '<h2 id="all-travellers">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-transiting-through-germany">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-not-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="if-youre-fully-vaccinated">Header</h2><p>Content</p>' \
              '<h2 id="children-and-young-people">Header</h2><p>Content</p>' \
              '<h2 id="exemptions">Header</h2><p>Content</p>',
            slug: 'entry-requirements'
          }
        ]
      }
    }.to_json

    stub_request(:get, 'https://www.gov.uk/api/content/foreign-travel-advice/spain').with(
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(status: 200, body: spain_response)

    stub_request(:get, 'https://www.gov.uk/api/content/foreign-travel-advice/france').with(
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(status: 200, body: france_response)

    stub_request(:get, 'https://www.gov.uk/api/content/foreign-travel-advice/germany').with(
      headers: { 'Content-Type' => 'application/json' }
    ).to_return(status: 200, body: germany_response)
  end
end
