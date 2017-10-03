context('Ticket Audits')

test_that('ticket audits downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    ticket_audits <- getTicketAudits(2)
    expect_is(ticket_audits, 'data.frame')
    expect_equivalent(nrow(ticket_audits), 1)
})