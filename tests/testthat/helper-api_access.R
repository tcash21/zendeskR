check_zendesk_login <- function() {
    # skip_on_cran()
    
    if (!file.exists('testing_login.R')) {
        skip("Please create a testing_login.R file with your 
             credentials in the zendesk() function to run 
             these tests")
    }
}

check_api <- function(){
    # skip_on_cran()
    
    check_zendesk_login()
    # not_working()
}

# TODO: add something to check that zendesk api is online
# not_working <- function() {
#     # this may be easier affter implementing .httr
#     source('testing_login.R')
# if () {
#         skip("API not available")
#     }
# }

# TODO: add a function to check if user is an admin
# Should do after adding functionality to pull specific
# users then check status of user from .ZendeskEnv$data$username