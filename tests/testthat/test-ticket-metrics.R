context('Ticket Metrics')

test_that('ticket metrics downloaded', {
    skip_on_cran()
    check_api()
    source('testing_login.R')
    all_metrics <- getAllTicketMetrics()
    expect_is(all_metrics, 'data.frame')
})