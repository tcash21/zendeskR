zendesk <- function(username, password, url, use_token = FALSE){
    if(!is.null(username) & !is.null(password) & !is.null(url)){
        if(use_token){
            .ZendeskEnv$data$username <- paste0(username,'/token')
        }else{
            .ZendeskEnv$data$username <- username
        }
        .ZendeskEnv$data$password <- password
        .ZendeskEnv$data$url <- gsub("\\/$","", url)
    }
    else{
        warning("Username, Password and URL must be provided in order to access your organization's data")
    }
}