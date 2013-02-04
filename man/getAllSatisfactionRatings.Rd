\name{getAllSatisfactionRatings}
\alias{getAllSatisfactionRatings}
\title{ getAllSatisfactionRatings}
\description{
This function is used to return all satisfaction ratings for your organization.
}
\usage{
## Admin only
getAllSatisfactionRatings()
}
\details{
This function can only be used by Admins within your organization. Satisfaction Ratings are ordered chronologically by created date, from oldest to newest.
}
\value{
returns a data.frame of all satisfaction ratings ordered chronologically by created date, from oldest to newest.
}
\references{
http://developer.zendesk.com/documentation/rest_api/satisfaction_ratings.html
}
\author{John Hornbeck}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    satisfaction_ratings <- getAllSatisfactionRatings()
}}
\keyword{ getAllSatisfactionRatings }
