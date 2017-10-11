context('Ticket')

test_that('ticket downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    ticket <- getTicket(2)
    expect_is(ticket, 'data.frame')
    expect_equivalent(nrow(ticket), 1)
})