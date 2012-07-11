\name{zendesk}
\alias{zendesk}
\title{ zendesk}
\description{
This function is used to create a Zendesk.com API session.
}
\usage{
zendesk(username, password, ZendeskURL)
}
\details{
This function will initialize a Zendesk.com API session.
}
\value{
returns a data.frame of all users
}
\references{
http://developer.zendesk.com/documentation/rest_api/introduction.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    zendesk('username', 'password', 'https://help.example.com')
}}
\keyword{ zendesk }
