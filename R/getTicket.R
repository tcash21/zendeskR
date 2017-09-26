#' getTicket
#'
#' This function is used to return ticket information for a given ticket ID
#'
#' This function will return a data.frame of ticket information for a 
#' given ticket.id. The fields key will be returned within the data.frame 
#' as a list.
#'
#' @param ticket.id A Zendesk ticket ID (e.g. 888)
#'
#' @return returns a data.frame of ticket information for the given ticket.id
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/tickets.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' ticket <- getTicket(ticket.id)
#' }

getTicket <- function(ticket.id){
        curl = getCurlHandle()
        stopPaging <- FALSE
        result <- list()
        i <- 1

	## Need to page through the results since only 100 are returned at a time
	while(stopPaging == FALSE){
            result[[i]]<-getURL(paste(.ZendeskEnv$data$url, gsub(".json", "", .ZendeskEnv$data$tickets), "/", ticket.id, ".json?page=" ,i, sep=""), curl=curl, 
                          ssl.verifypeer=FALSE, .opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))
            if(is.null(fromJSON(result[[i]])$next_page)){
                stopPaging <- TRUE
            }
            i <- i + 1
        }

	## Transform the JSON data to a data.frame
        json.data <- lapply(unlist(result), fromJSON)
        pre.result <- lapply(json.data, function(x) do.call("rbind", x))
        final.result<-do.call("rbind", pre.result)
        ticket.df <- data.frame(final.result)
	ticket.df <- unlistDataFrame(ticket.df)
        return(ticket.df)
}



