# Datacite to Facility convertor

* DOI -> UniqueID
* titles/title -> Name
* "Seismic Network" -> type **Nice to have: permanent or temporary; but it's not available**
* N/A -> Country (NRI) **Suggestion: Change cardinality to N instead of 1**
* Contributors/DataCollector -> Organization (Name, Role, ID)
* Contributors/DataManager -> Organization (Name, Role, ID)
* Contributors/Distributor -> Organization (Name, Role, ID)
* http://dx.doi.org/[DOI] -> website
* "Seismology" -> science domain
* Contributors/ContactPerson -> Contact (Given Name, Last Name, ID)
* Creators/Creator -> Facility manager (Given Name, Last Name, ID) **Suggestion: Change cardinality to N instead of 1**
* Descriptions/Description -> description

Relationships with other entities still not included.
