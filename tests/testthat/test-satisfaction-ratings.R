context('Satisfaction Ratings')

test_that('satisfaction ratings downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    all_ratings <- getAllSatisfactionRatings()
    expect_is(all_ratings, 'data.frame')
})
