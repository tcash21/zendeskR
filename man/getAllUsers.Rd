\name{getAllUsers}
\alias{getAllUsers}
\title{ getAllUsers}
\description{
This function is used to retrieve information on all registered Zendesk users in your organization
}
\usage{
getAllUsers()
}
\details{
This function will return a data.frame containing all fields on every user in your organization.
The photo key will be returned within the data.frame as a list.
}
\value{
returns a data.frame of all users
}
\references{
http://developer.zendesk.com/documentation/rest_api/users.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    users <- getAllUsers()
}}
\keyword{ getAllUsers }
