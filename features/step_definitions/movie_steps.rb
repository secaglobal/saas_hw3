# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  Movie.all_ratings.each do |rate|
    uncheck 'ratings_' + rate
  end


  rating_list.scan /\w+/ do |rate|
    check 'ratings_' + rate
  end

  click_button('ratings_submit')
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should (not )?see movies\:/ do |exclude, list|
  list.hashes.each do |movie|
    step %Q{I should #{exclude}see "#{movie['title']}"}
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /(all|no) ratings selected/ do |all|
  #handler = all ? check : uncheck
  Movie.all_ratings.each do |rate|
    case 'all'
    when'all' then check 'ratings_' + rate
    else uncheck 'ratings_' + rate
    end
  end

  click_button('ratings_submit')
end