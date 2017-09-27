#' getAllUsers
#'
#' This function is used to retrieve information on all registered Zendesk users in your organization
#'
#' This function will return a data.frame containing all fields on 
#' every user in your organization. The photo key will be returned 
#' within the data.frame as a list.
#'
#' @return returns a data.frame of all users
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/users.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' zendesk('username', 'password', 'https://help.example.com')
#' users <- getAllUsers()
#' }


getAllUsers <- function(){
	curl <- getCurlHandle()
    	result <- list()
    	stopPaging <- FALSE
    	i <- 1

	## Need to page through the results since only 100 are returned at a time
	while(stopPaging==FALSE){
        	result[[i]]<-getURL(paste(.ZendeskEnv$data$url, .ZendeskEnv$data$users, "?page=", i, sep=""), curl=curl, ssl.verifypeer=FALSE,
				.opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))
        	if(is.null(fromJSON(result[[i]])$next_page)){
            		stopPaging = TRUE
        	}
        i <- i + 1
    	}
    
        ## Transform the JSON data to a data.frame
	json.data <- lapply(unlist(result), fromJSON)
        pre.result <- lapply(json.data, function(x) do.call("rbind", x$users))
        final.result<-do.call("rbind", pre.result)
        users.df <- data.frame(final.result)
	users.df <- unlistDataFrame(users.df)
        return(users.df)
}        


