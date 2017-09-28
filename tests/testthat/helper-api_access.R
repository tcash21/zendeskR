check_zendesk_login <- function() {
    if (!file.exists('testing_login.R')) {
        skip("Please create a testing_login.R file with your 
             credentials in the zendesk() function to run 
             these tests")
    }
}

not_working <- function() {
    source('testing_login.R')
}

check_api <- function() {
    if (not_working()) {
        skip("API not available")
    }
}


