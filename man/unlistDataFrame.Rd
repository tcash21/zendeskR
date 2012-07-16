\name{unlistDataframe}
\alias{unlistDataFrame}
\title{unlistDataFrame}
\description{
Utility function to unlist the columns of each data.frame where necessary. 
}
\usage{
unlistDataFrame(dataframe)
}
\arguments{
        \item{dataframe}{
        A data.frame containing columns of lists to be unlisted.
        }
}
\details{
This function will return a data.frame with the list type columns unlisted except where a column is a list of lists.
}
\value{
returns a data.frame
}
\author{Tanya Cashorali}
\examples{
\dontrun{
    ## This requires Zendesk authentication
     unlistDataFrame(dataframe)
}}
\keyword{ unlistDataFrame }
