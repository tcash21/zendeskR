#' getAllOrganizations
#'
#' This function is used to retrieve information on all 
#' registered organizations in your Zendesk organization
#'
#' This function will return a data.frame containing all fields on every organization.  
#' The tags key will be returned within the data.frame as a list.
#'
#' @return returns a data.frame of all organizations
#' @export
#' 
#' @author Tanya Cashorali 
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/organizations.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' organizations <- getAllOrganizations()
#' }

getAllOrganizations <- function(){
        curl = getCurlHandle()
        stopPaging <- FALSE
        result <- list()
        i <- 1
	
	## Need to page through the results since only 100 are returned at a time
	while(stopPaging == FALSE){
            result[[i]]<-getURL(paste(.ZendeskEnv$data$url, .ZendeskEnv$data$organizations, "?page=" ,i, sep=""), curl=curl, ssl.verifypeer=FALSE,
				.opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))
            if(is.null(fromJSON(result[[i]])$next_page)){
                stopPaging <- TRUE
            }
            i <- i + 1
        }

        ## Transform the JSON data to a data.frame
	json.data <- lapply(unlist(result), fromJSON)
        pre.result <- lapply(json.data, function(x) do.call("rbind", x$organizations))
        final.result<-do.call("rbind", pre.result)
        orgs.df <- data.frame(final.result)
 	orgs.df <- unlistDataFrame(orgs.df)
	return(orgs.df)
}