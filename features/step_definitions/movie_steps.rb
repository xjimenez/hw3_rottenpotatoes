# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    ## Uncomment the following line for debugging purposes:
    # debugger
  end
  # flunk "Unimplemented"
end

# Hw3 part2.
When /^all ratings are checked$/ do
  check("ratings_G")
  check("ratings_PG")
  check("ratings_R")
  check("ratings_PG-13")
  check("ratings_NC-17")
  click_button("Refresh")
end

When /^no ratings are checked$/ do
  uncheck("ratings_G")
  uncheck("ratings_PG")
  uncheck("ratings_R")
  uncheck("ratings_PG-13")
  uncheck("ratings_NC-17")
  click_button("Refresh")
end

# Hw3 part2.
Then /I should (not )?see the following movies/ do |visible, movies_table|
  movies_table.hashes.each do |movie|
    movie_title = movie['title']
    step "I should " + visible.to_s + "see \"#{movie_title}\""
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
