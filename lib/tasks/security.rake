# frozen_string_literal: true

desc "Run Brakeman"
task security: [:environment] do
  sh "bundle exec brakeman . --no-summary --quiet"
end
