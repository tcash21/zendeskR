zendeskR - R wrapper to the Zendesk API
=========

For more information on the Zendesk API see: <a href = "http://developer.zendesk.com/documentation/rest_api/introduction.html">
http://developer.zendesk.com/documentation/rest_api/introduction.html</a>

Current API calls supported
-------------
    getAllUsers()                - return all users in your Zendesk organization
    getAllTickets()              - return all tickets (admin only)
    getTickets(organizationID)   - return all tickets for the given organization ID
    getTicket(ticket.id)         - return information for the given ticket ID
    getTicketAudits(ticket.id)   - return all audits for the given ticket ID
    getOrganizations()           - return all organizations registered in your Zendesk organization

This package is a work in progress. It started out as a useful utility for myself. 
I will be adding more functionality and API calls over time. If there is a particular function you would like to see added, please do not hesitate to contact me. 

<i>Last Update: 7-17-2012</i>

Installation
---------
To install from CRAN, type in an R console:

    > install.packages("zendeskR", dependencies=TRUE)

To install this package from the source code available here, download it, and set your R working directory to wherever you saved the file. Then run:

    > install.packages("zendeskR_0.1.tar.gz", repos=NULL, type="source")

Example Usage
------- 
    ## Initiate a Zendesk API session
    zendesk("username", "password", "https://help.basho.com") ## Your Zendesk credentials and organization URL
    users <- getAllUsers()

Contact
------------
Tanya Cashorali
<ul>
	<li>email: tanyacash@gmail.com</li>
	<li>twitter: tanyacash21</li>
</ul>



