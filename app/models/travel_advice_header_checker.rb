# frozen_string_literal: true

class TravelAdviceHeaderChecker
  attr_reader :country_slug, :base_url, :request_headers

  def initialize(country_slug)
    @country_slug = country_slug
    @base_url = "https://www.gov.uk/api/content/foreign-travel-advice"
    @request_headers = { "Content-Type" => "application/json" }
  end

  def self.countries_header_status
    results = []
    countries.each do |country|
      checker = TravelAdviceHeaderChecker.new(country.first)
      entry_requirements = checker.entry_requirements_body_content

      results << {
        "slug" => country.first,
        "name" => country.last,
        "all_travellers" => checker.content_header?(entry_requirements, "all-travellers"),
        "transiting" => checker.content_header?(entry_requirements, "if-youre-transiting-through-#{country.first}"),
        "not_fully_vaccinated" => checker.content_header?(entry_requirements, "if-youre-not-fully-vaccinated"),
        "fully_vaccinated" => checker.content_header?(entry_requirements, "if-youre-fully-vaccinated"),
        "children_young" => checker.content_header?(entry_requirements, "children-and-young-people"),
        "exemptions" => checker.content_header?(entry_requirements, "exemptions"),
      }
    end
    results
  end

  def self.countries
    checker = TravelAdviceHeaderChecker.new(nil)
    response = checker.get_response(checker.base_url)
    return {} if response.blank? || response.body.blank?

    parsed_response = checker.parse_response(response)
    return {} if parsed_response.blank?

    countries = {}
    parsed_response.dig("links", "children").each do |child|
      country = child.dig("details", "country")
      countries[country["slug"]] = country["name"]
    end
    countries.sort.to_h
  end

  def content
    content = {}

    entry_requirements = entry_requirements_body_content
    return content if entry_requirements.blank?

    content_headers.each do |header|
      node = entry_requirements.at_css("[id='#{header}']")
      content[header] = child_nodes(node).join
    end

    content
  end

  def content_headers?
    entry_requirements = entry_requirements_body_content
    return false if entry_requirements.blank?

    content_headers.each do |header|
      return false unless content_header?(entry_requirements, header)
    end

    true
  end

  def content_headers
    [
      "all-travellers",
      "if-youre-transiting-through-#{country_slug}",
      "if-youre-not-fully-vaccinated",
      "if-youre-fully-vaccinated",
      "children-and-young-people",
      "exemptions",
    ]
  end

  def entry_requirements_body_content
    response = get_response("#{base_url}/#{country_slug}")
    return nil if response.blank? || response.body.blank?

    parsed_response = parse_response(response)
    return nil if parsed_response.blank?

    parsed_response.dig("details", "parts").each do |part|
      return Nokogiri::HTML.parse(part["body"]) if part["slug"] == "entry-requirements"
    end

    nil
  end

  def get_response(url)
    HTTParty.get(url, headers: request_headers)
  end

  def parse_response(response)
    JSON.parse(response.body)
  end

  def content_header?(entry_requirements, header)
    node = entry_requirements.at_css("[id='#{header}']")
    node.present? && node.children.any?
  end

  def child_nodes(node)
    current_node = node.next
    content = []
    loop do
      break if current_node.nil? || %w[h1 h2].include?(current_node.name)

      content << current_node.to_html.gsub("\n", "")
      current_node = current_node.next
    end
    content
  end
end
