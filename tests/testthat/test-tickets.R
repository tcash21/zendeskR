context('Tickets')

test_that('tickets downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    all_tickets <- getAllTickets()
    expect_is(all_tickets, 'data.frame')
})