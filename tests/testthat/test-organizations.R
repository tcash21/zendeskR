context('Organizations')

test_that('organizations downloaded', {
    check_zendesk_login()
    source('testing_login.R')
    all_orgs <- getAllOrganizations()
    expect_is(all_orgs, 'data.frame')
})
