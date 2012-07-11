\name{getAllTickets}
\alias{getAllTickets}
\title{ getAllTickets}
\description{
This function is used to return all tickets stored in your organization.
}
\usage{
## Admin only
getAllTickets()
}
\details{
This function can only be used by Admins within your organization. Tickets are ordered chronologically by created date, from oldest to newest.
}
\value{
returns a data.frame of all tickets ordered chronologically by created date, from oldest to newest.
}
\references{
http://developer.zendesk.com/documentation/rest_api/tickets.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    tickets <- getAllTickets()
}}
\keyword{ getAllTickets }
