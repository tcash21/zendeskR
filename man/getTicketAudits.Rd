\name{getTicketAudits}
\alias{getTicketAudits}
\title{ getTicketAudits}
\description{
This function is used to return all ticket audits for a given ticket ID.
}
\usage{
getTicketAudits(ticket.id)
}
\arguments{
	\item{ticket.id}{
	A Zendesk ticket ID (e.g. 888)
	}
}
\details{
Audits are a read-only history of all updates to a ticket and the events that occur as a result of these updates. When a Ticket is updated in Zendesk, we store an Audit. Each Audit represents a single update to the Ticket, and each Audit includes a list of changes, such as changes to ticket fields, addition of a new comment, addition or removal of tags, notifications sent to groups, assignees, requesters and CCs
}
\value{
returns a data.frame of all ticket audits for a given ticket ID.
}
\references{
http://developer.zendesk.com/documentation/rest_api/ticket_audits.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    audits <- getTicketAudits(ticket.id)
}}
\keyword{ getTicketAudits }
