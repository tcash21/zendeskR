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
    endpoint <- paste0(.ZendeskEnv$data$url, '/api/v2/', zd_call, '.json')
    response <- zendesk_call(endpoint, zd_call, ...)
    results[[i]] <- response$df
    stop_paging <- is.null(response$next_page)
    
    while(!stop_paging) {
        i <- i + 1
        response <- zendesk_call(response$next_page, zd_call,...)
        results[[i]] <- response$df
        stop_paging <- is.null(response$next_page)
    }
    dplyr::bind_rows(results)
}


#' zendesk_call
#' 
#' A helper function for making api calls in zendesk_get funtion
#' 
#' This function will make one api call to the provided link and return a list
#' of the dataframe with the content of the api call as well as the next link
#' provided by the cull (will be null if there are no more pages)
#'
#' @param link the full api endpoint link to be called
#' @param zd_call the endpoint to call
#' @param ... any valid parameter to be passed from zendesk_get
#'
#' @return a list of the resulting dataframe from one api call and its next link
#'
#' @examples
zendesk_call <- function(link, zd_call, ...){
    result <- list()
    response <- httr::GET(link,
                          httr::authenticate(.ZendeskEnv$data$username,
                                             .ZendeskEnv$data$password),
                          query = list(...))
    response_json <- httr::content(response, 'text')
    result$df <- jsonlite::fromJSON(response_json)[[zd_call]]
    result$df <- jsonlite::flatten(result$df)
    result$next_page <- httr::content(response)$next_page
    result
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


