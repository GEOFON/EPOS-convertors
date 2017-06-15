# StationXML to Equipment convertor

* NET.STA.LOC.CH[2 letters]-STARTDATE -> Unique identifier
* Sensor/SerialNumber + Datalogger/SerialNumber -> SerialNumber
* [Description from Seed Manual about 2nd letter from channel] -> type
* Number of components -> quantity
* DataLogger/Manufacturer -> manufacturer
* Same as 'type' + Site/Name + Site/Country -> description
* @startdate + @enddate -> TimePeriod
* NET.STA.LOC.CH[2 letters] -> InstrumentName
* Azimuth + Dip -> Orientation (xyz)
* N/A -> DynamicRange
* N/A -> Resolution
* 1/SampleRate + 's' -> SamplePeriod (value, unit)
* N/A -> filter
* POINT(Longitude, Latitude, Elevation) -> Location

Relationships with other entities still not included.
