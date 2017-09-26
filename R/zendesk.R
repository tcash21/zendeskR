#' zendesk
#'
#' This function is used to create a Zendesk.com API session.
#'
#' This function will initialize a Zendesk.com API session.
#'
#' @param username Your Zendesk username.
#' @param password Your Zendesk password (or API token).
#' @param url Your organization's Zendesk URL (e.g. https://help.basho.com).
#'
#' @return Initializes a Zendesk.com API session. Will throw an error if all 3 parameters are not passed to the function.
#' @export
#' 
#' @author Tanya Cashorali
#'
#' @references \url{http://developer.zendesk.com/documentation/rest_api/introduction.html}
#'
#' @examples \dontrun{
#' 
#' ## This requires Zendesk authentication
#' zendesk('username', 'password', 'https://help.basho.com')
#' }

zendesk <- function(username, password, url){
    if(!is.null(username) & !is.null(password) & !is.null(url)){
        .ZendeskEnv$data$username <- username
        .ZendeskEnv$data$password <- password
        .ZendeskEnv$data$url <- gsub("\\/$","", url)
    }
    else{
        warning("Username, Password and URL must be provided in order to access your organization's data")
    }
}