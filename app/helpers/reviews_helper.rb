module ReviewsHelper
  def distance_of_time_in_hours(time)
    distance_in_hours = ((Time.current - time) / 1.hour).round
    "#{distance_in_hours} #{'hour'.pluralize(distance_in_hours)}"
  end
end
