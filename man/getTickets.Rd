\name{getTickets}
\alias{getTickets}
\title{ getTickets}
\description{
This function is used to return all tickets for a given Zendesk organization
}
\usage{
getTickets(org.id)
}
\arguments{
	\item{org.id}{
		A Zendesk organization ID (e.g. 118862)
	}
}
\details{
This function will return a data.frame of all tickets for a given organization.
The fields key will be returned within the data.frame as a list.
}
\value{
returns a data.frame of all tickets for the given organization
}
\references{
http://developer.zendesk.com/documentation/rest_api/tickets.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    tickets <- getTickets(org.id)
}}
\keyword{ getTickets }
