# frozen_string_literal: true

class Location < ApplicationRecord
  def self.completed_stats
    {
      "all" => completed_slugs.count,
      "all_travellers" => where("all_travellers = true").count,
      "transiting" => where("transiting = true").count,
      "not_fully_vaccinated" => where("not_fully_vaccinated = true").count,
      "fully_vaccinated" => where("fully_vaccinated = true").count,
      "children_young" => where("children_young = true").count,
      "exemptions" => where("exemptions = true").count,
    }
  end

  def self.completed_slugs
    where(
      all_travellers: true,
      transiting: true,
      not_fully_vaccinated: true,
      fully_vaccinated: true,
      children_young: true,
      exemptions: true,
    ).map(&:slug).sort
  end

  def complete?
    all_travellers && transiting && not_fully_vaccinated && fully_vaccinated && children_young && exemptions
  end
end
