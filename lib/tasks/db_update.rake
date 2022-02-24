# frozen_string_literal: true

namespace :db do
  desc 'Deletes all data from the database and reloads it from the Foreign Travel Advice API'
  task update: :environment do
    Location.destroy_all
    TravelAdviceHeaderChecker.countries_header_status.each do |country_data|
      Location.create!(country_data)
    end
  end
end
