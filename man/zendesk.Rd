\name{zendesk}
\alias{zendesk}
\title{ zendesk}
\description{
This function is used to create a Zendesk.com API session.
}
\usage{
zendesk(username, password, url)
}
\arguments{
	\item{username}{
		Your Zendesk username.
	}
	\item{password}{
		Your Zendesk password.
	}
	\item{url}{
		Your organization's Zendesk URL (e.g. https://help.basho.com).
	}
}	
\details{
This function will initialize a Zendesk.com API session.
}
\value{
Initializes a Zendesk.com API session. Will throw an error if all 3 parameters are not passed to the function.
}
\references{
http://developer.zendesk.com/documentation/rest_api/introduction.html
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
    zendesk('username', 'password', 'https://help.basho.com')
}}
\keyword{ zendesk }
