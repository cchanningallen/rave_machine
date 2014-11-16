class Event < ActiveRecord::Base
  validate :no_duplicate_name_date_location_combinations, on: :create

  def no_duplicate_name_date_location_combinations
    if self.class.where(name: name, date: date, location: location).any?
      errors.add(:base, "An event with this name, date, and location already exists!")
    end
  end
end
