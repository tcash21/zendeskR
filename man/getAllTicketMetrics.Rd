\name{getAllTicketMetrics}
\alias{getAllTicketMetrics}
\title{ getAllTicketMetrics}
\description{
This function is used to retrieve all ticket metrics from all tickets in your Zendesk organization
}
\usage{
getAllTicketMetrics()
}
\details{
This function will return a data.frame containing all ticket metrics, such as latest_comment_added_at, first_resolution_time_in_minutes, etc. on every ticket.
}
\value{
returns a data.frame of all ticket metrics for all tickets
}
\references{
http://developer.zendesk.com/documentation/rest_api/ticket_metrics.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    ticket_metrics <- getAllTicketMetrics()
}}
\keyword{ getAllTicketMetrics }


