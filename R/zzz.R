#' R Wrapper for Zendesk API
#'
#' This package provides an R wrapper to the Zendesk API.
#'
#' \tabular{ll}{
#' Package: \tab zendeskR\cr
#' Type: \tab Package\cr
#' Version: \tab 0.1\cr
#' Date: \tab 2012-07-11\cr
#' License: \tab Simplified BSD\cr
#' }
#' 
#' @author Tanya Cashorali Tanya Cashorali: <tanyacash@gmail.com>
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/introduction.html}
#' @docType package
#' @name zendeskR
NULL

.ZendeskEnv <- new.env()
.ZendeskEnv$data <- list()

.onLoad <- function(libname, pkgname){
    if(is.null(.ZendeskEnv$data) == FALSE){
    	.ZendeskEnv$data <- list(
        	username <- NULL,
        	password <- NULL,
        	url <- NULL,
		      users = "/api/v2/users.json",
		      tickets = "/api/v2/tickets.json",
		      audits = "/audits.json",
		      organizations = "/api/v2/organizations.json",
          ticket_metrics = "/api/v2/ticket_metrics.json",
          satisfaction_ratings = "/api/v2/satisfaction_ratings.json"
		
            )
    }
}

#' zendesk_get
#' 
#' This is a a general purpose function for any valid Zendesk API endpoint
#' 
#' This function will return a data.frame of the results returned from the
#' zendesk API for the endpoint passed to it. Any valid parameters can be passed
#' to refine the request, for some endpoints there are required parameters.
#' 
#' @param zd_call the api call (tickets, users, etc.)
#' @param ... any valid parameters for the associated call
#'
#' @return returns a data.frame of the results from the given call
#' @export
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' tickets <- zendesk_get('tickets')
#' }
zendesk_get <- function(zd_call, ...){
    results <- list()
    i <- 1
    response <- httr::GET(paste0(.ZendeskEnv$data$url, '/api/v2/',
                                 zd_call, '.json'),
                         httr::authenticate(.ZendeskEnv$data$username,
                                            .ZendeskEnv$data$password),
                         query = list(...))
    response_json <- httr::content(response, 'text')
    results[[i]] <- jsonlite::fromJSON(response_json)[[zd_call]]
    stop_paging <- is.null(httr::content(response)$next_page)
    
    while(!stop_paging) {
        i <- i + 1
        response <- httr::GET(httr::content(response)$next_page,
                              httr::authenticate(.ZendeskEnv$data$username,
                                                 .ZendeskEnv$data$password))
        response_json <- httr::content(response, 'text')
        results[[i]] <- jsonlite::fromJSON(response_json)[[zd_call]]
        stop_paging <- is.null(httr::content(response)$next_page)
    }
    tidy_results(results)
}

tidy_results <- function(results_list){
    output <- data.frame()
    for(i in 1:length(results_list)){
        output <- dplyr::bind_rows(output, 
                                   jsonlite::flatten(results_list[[i]]))
    }
    output
}

#' unlistDataFrame
#'
#' Utility function to unlist the columns of each data.frame where necessary.
#'
#' This function will return a data.frame with the list type columns unlisted 
#' except where a column is a list of lists.
#'
#' @param dataframe A data.frame containing columns of lists to be unlisted.
#'
#' @return returns a data.frame
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/tickets.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' unlistDataFrame(dataframe)
#' }
unlistDataFrame <-
function(dataframe){
	n <- dim(dataframe)[1]
	dim.df <- dim(dataframe)[2]

##	Not sure why vectorized version of this doesn't work
##	apply(dataframe, 2, function(x) { if (length(unlist(x)) == n) unlist(x)} )

	for(i in 1:dim.df){
		if(length(unlist(dataframe[,i])) == n){
			dataframe[,i] <- unlist(dataframe[,i])
		}
		if(length(unlist(dataframe[,i])) < n){
			dataframe[,i] <- as.character(dataframe[,i])
		}
	}

	return (dataframe)
}


