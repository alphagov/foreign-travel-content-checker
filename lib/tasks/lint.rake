# frozen_string_literal: true

desc 'Run all linters'
task lint: [:environment] do
  sh 'bundle exec rubocop'
end
