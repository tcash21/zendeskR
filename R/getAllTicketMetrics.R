#' getAllTicketMetrics
#'
#' This function is used to retrieve all ticket metrics from all tickets in your Zendesk organization
#'
#' This function will return a data.frame containing all ticket metrics, 
#' such as latest_comment_added_at, first_resolution_time_in_minutes, etc. 
#' on every ticket.
#'
#' @return returns a data.frame of all ticket metrics for all tickets
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/ticket_metrics.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' ticket_metrics <- getAllTicketMetrics()
#' }

getAllTicketMetrics <- function(){
  curl <- getCurlHandle()
  result <- list()
  stopPaging <- FALSE
  i <- 1
  
  ## Need to page through the results since only 100 are returned at a time
  while(stopPaging==FALSE){
    result[[i]]<-getURL(paste(.ZendeskEnv$data$url, .ZendeskEnv$data$ticket_metrics, "?page=", i, sep=""), curl=curl, ssl.verifypeer=FALSE,
                        .opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))
    if(is.null(fromJSON(result[[i]])$next_page)){
      stopPaging = TRUE
    }
    i <- i + 1
  }
  
  ## Transform the JSON data to a data.frame
  json.data <- lapply(unlist(result), fromJSON)
  pre.result <- lapply(json.data, function(x) do.call("rbind", x$ticket_metrics))
  final.result<-do.call("rbind", pre.result)
  ticket_metrics.df <- data.frame(final.result)
  ticket_metrics.df <- unlistDataFrame(ticket_metrics.df)
  return(ticket_metrics.df)
}        

