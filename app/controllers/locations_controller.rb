# frozen_string_literal: true

require "rake"

Rake::Task.clear
ForeignTravelContentChecker::Application.load_tasks

class LocationsController < ApplicationController
  before_action :error_if_passed_deadline

  def index
    @locations = Location.all.order(name: :asc)
    @completed_stats = Location.completed_stats
  end

  def show
    @location = Location.find_by(slug: params[:slug])
    @content = TravelAdviceHeaderChecker.new(params[:slug]).content
  end

  def update
    Rake::Task["db:update"].reenable
    Rake::Task["db:update"].invoke
    redirect_to action: "index"
  end

  def completed
    respond_to do |format|
      format.json { render json: Location.completed_slugs.to_json }
    end
  end

private

  def error_if_passed_deadline
    return unless Time.zone.today > Date.parse("01/06/2022")

    raise StandardError.new("This app exceeds it's deadline date"), status: 500
  end
end
