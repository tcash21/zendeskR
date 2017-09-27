#' getAllTickets
#'
#' This function is used to return all tickets stored in your organization.
#'
#' This function can only be used by Admins within your organization. 
#' Tickets are ordered chronologically by created date, from oldest to newest.
#'
#' @return returns a data.frame of all tickets ordered chronologically by created date, from oldest to newest.
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/tickets.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' tickets <- getAllTickets()
#' }

getAllTickets <- function(){
        curl = getCurlHandle()
        stopPaging <- FALSE
        result <- list()
        i <- 1

	## Need to page through the results since only 100 are returned at a time
        while(stopPaging == FALSE){
            result[[i]]<-getURL(paste(.ZendeskEnv$data$url, .ZendeskEnv$data$tickets, "?page=" ,i, sep=""), curl=curl, ssl.verifypeer=FALSE,
				.opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))    
            if(is.null(fromJSON(result[[i]])$next_page)){
                stopPaging <- TRUE
            }
            i <- i + 1
        }
	
	## Transform the JSON data to a data.frame
        json.data <- lapply(unlist(result), fromJSON)
        pre.result <- lapply(json.data, function(x) ldply(x$tickets, rbind))
        final.result<-ldply(pre.result, rbind)
        tickets.df <- data.frame(final.result)
	tickets.df <- unlistDataFrame(tickets.df)
        return(tickets.df)
}

