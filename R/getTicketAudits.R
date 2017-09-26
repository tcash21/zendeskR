#' getTicketAudits
#'
#' This function is used to return all ticket audits for a given ticket ID.
#'
#' Audits are a read-only history of all updates to a ticket and the events 
#' that occur as a result of these updates. When a Ticket is updated in Zendesk,
#' we store an Audit. Each Audit represents a single update to the Ticket, and
#' each Audit includes a list of changes, such as changes to ticket fields, 
#' addition of a new comment, addition or removal of tags, notifications sent 
#' to groups, assignees, requesters and CCs
#'
#' @param ticket.id A Zendesk ticket ID (e.g. 888)
#'
#' @return returns a data.frame of all ticket audits for a given ticket ID.
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/ticket_audits.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' audits <- getTicketAudits(ticket.id)
#' }

getTicketAudits <- function(ticket.id){
        curl = getCurlHandle()
        stopPaging <- FALSE
        result <- list()
        i <- 1

	## Need to page through the results since only 100 are returned at a time
	while(stopPaging == FALSE){
            result[[i]]<-getURL(paste(.ZendeskEnv$data$url, gsub(".json", "", .ZendeskEnv$data$tickets), "/", ticket.id, .ZendeskEnv$data$audits, "?page=" ,i, sep=""), curl=curl, ssl.verifypeer=FALSE,
				.opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))    
            if(is.null(fromJSON(result[[i]])$next_page)){
                stopPaging <- TRUE
            }
            i <- i + 1
        }

        json.data <- lapply(unlist(result), fromJSON)
        
        pre.result <- lapply(json.data, function(x) do.call("rbind", x$audits))
        final.result<-do.call("rbind", pre.result)
        audits.df <- data.frame(final.result)
	audits.df <- unlistDataFrame(audits.df)	      
        return(audits.df)
}
