context('Organizations')

test_that('organizations downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    all_orgs <- getAllOrganizations()
    expect_is(all_orgs, 'data.frame')
})
