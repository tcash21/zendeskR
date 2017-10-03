context('Users')

test_that('users downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    all_users <- getAllUsers()
    expect_is(all_users, 'data.frame')
})