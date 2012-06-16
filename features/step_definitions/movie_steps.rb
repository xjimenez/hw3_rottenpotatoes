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

# Hw3 part2c.
Then /I should see all of the movies/ do
  # save_and_open_page
  page.all(:css, 'tbody#movielist tr td a').count.should == 10
end

## Make sure that title e1 occurs before another title e2.
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # save_and_open_page
  # page.should have_content("Chicken Run")
  # NO! page.should have_css('tr td:contains("Chicken Run")') checks the td not the parent tr.
  # ALMOST! page.should have_css('tr:contains("Chicken Run")') checks the tr
  # GOTCHA! page.should have_css('tr:contains("Chicken Run") ~ tr:contains("The Help")')
  page.should have_css('tr:contains("' + e1 + '") ~ tr:contains("' + e2 + '")')

  # pp1 = page.first(:xpath, '//tr[contains(., "Chicken Run")]/following-sibling::*[contains(., "The Help")]')
  # pp1 = page.first(:xpath, '//tr[contains(., "Chicken Run")] ~ //tr[contains(., "The Help")]')
  # pp2 = page.first(:xpath, '//tr[contains(., "The Help")]').value
  # pp1 = page.find('tr[contains(\"' + e1 + '\"')
  # pp2 = page.find("#movielist tr:contains('" + e2 + "'")
  # page.should have_css('tbody#movielist//:contains("' + e1 + '")+tbody#movielist//:contains("' + e2 +'")')
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck_flag, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck_flag == nil
    rating_list.split(', ').each do |rating|
      check("ratings_" + rating)
    end
  else
    rating_list.split(', ').each do |rating|
      uncheck("ratings_" + rating)
    end
  end
  click_button("Refresh")  
end

