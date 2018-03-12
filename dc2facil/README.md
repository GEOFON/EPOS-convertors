# Datacite to Facility convertor

* DOI -> UniqueID
* titles/title -> Name
* "Seismic Network" -> type **Nice to have: permanent or temporary; but it's not available**
* N/A -> Country (NRI) **Suggestion: Change cardinality to N instead of 1**
* Contributors/DataCollector -> PIC (Organization name, Role)
* Contributors/DataManager -> PIC (Organization name, Role)
* Contributors/Distributor -> PIC (Organization name, Role)
* http://dx.doi.org/[DOI] -> website
* "Seismology" -> science domain
* Contributors/ContactPerson -> ORCID of Contact (Given Name, Last Name)
* Creators/Creator -> ORCID of Facility manager (Given Name, Last Name) **Suggestion: Change cardinality to N instead of 1**
* Descriptions/Description -> description

P.S.1: Relationships with other entities still not included.

P.S.2: From the discussion in Milano it was decided that ORCIDs will be used for Persons whenever possible and the PIC number (EU Projects) for Organizations.
