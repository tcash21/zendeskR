\name{getTicket}
\alias{getTicket}
\title{ getTicket}
\description{
This function is used to return ticket information for a given ticket ID
}
\usage{
getTicket(ticket.id)
}
\arguments{
	\item{ticket.id}{
	A Zendesk ticket ID number (e.g.888)
	}
}
\details{
This function will return a data.frame of ticket information for a given ticket.id.
The fields key will be returned within the data.frame as a list.
}
\value{
returns a data.frame of ticket information for the given ticket.id
}
\references{
http://developer.zendesk.com/documentation/rest_api/tickets.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    ticket <- getTicket(ticket.id)
}}
\keyword{ getTicket }


