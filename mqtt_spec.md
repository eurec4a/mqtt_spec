# EUREC4A MQTT broker message specification

## General

The [EUREC4A](https://www.eurec4a.eu) MQTT broker is intended to exchange various pieces of live information during the EUREC4A field campaign.

## Messages
All messages are encoded as JSON. Timestamps are given in UTC and encoded according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). Any physical quantities must be given in terms of the appropriate [SI base units](https://en.wikipedia.org/wiki/SI_base_unit) if not designated otherwise.
Pleas note that in this document, all values are given in "" marks, because otherwise JSON code formatters will complain.
If the values are actually numbers, they SHOULD NOT be entered as strings, but as the appropriate JSON type.

### Platforms
Platforms are assets which may move independently throughout the world.
This includes ships, aircraft, drones, gliders, drifter, balloons and so on.
Platforms are identified by a unique `<platform id>`.
Each platform gets its own namespace under `platform/<platform id>`.

#### meta
A platform MUST publish a retained message containing a general description of itself under `platform/<platform id>/meta`.
The contents of this message are as follows:
```json
{
    "long_name": "<full name of the platform>",
    "planet_id": "<identifier for the PLANET system>",
    "platform_types": ["list", "of types characterizing the platform", "in decending oder of specificity"],
    "url": "<web link for more information about the platform>",
    "urls": [{"list of urls": "as above"}],
    "contact": {
        "name": "<name of contact>",
        "email": "<email of contact>",
        "tags": ["list", "of tags", "indicating involvement"]
    },
    "contacts": [{"list of concacts": "as above"}],
    "expected_update_intervall": "<expected intervall of updates in seconds>",
    "misc": "<miscelaneous information to the platform>"
}
```
Platforms should send as many information as possible.
If any information is not available, the field should be omitted.

The `platform_types` can be filled with an arbitrary amount of names describing the kind of the platform.
The most specific names must be written first. This is primarity intended to facilitate the selection of display icons. An icon selection algorithm can walk through this list and display an icon corresponding to the first item in this list.
If any of the following names matches the type of the platform, it should be used exactly as in this list:

* buoy
* coastal vessel
* deep-sea vessel
* drifter
* glider
* ocean glider
* wave glider
* mooring
* plane
* saildrone
* ship
* station
* ground station

Other names may be used as well.
It may however be a good idea to add those names to this list.

While contact tags may also be chosen freely, reusing others is a good idea as well.
Known contact tags are:

* `dp` - data provider
* `fx` - flight management
* `pi` - principal investigator
* `pm` - project management
* `sc` - scientist

#### location
Each platform SHOULD publish messages identifying its location.
The contents of this message are as follows:
```json
{
    "time": "<time of position acquisition>",
    "lat": "<latitude in decimal WGS84 coordinates, degrees, north positive>",
    "lon": "<longitude in decimal WGS84 coordinates, degrees, east positive>",
    "heading": "<clockwise heading of the platform, degrees, north is 0>",
    "ground_speed": "<platform speed over ground, unit: m/s>",
    "press_alt": "<pressure altitude, unit: feet>",
    "gps_msl_alt": "<altitude above mean sea level, unit: m>",
    "wgs84_alt": "<altitude in WGS84 coordinates, unit: m>",
    "vert_velocity": "<vertical velocity, unit: m/s>",
    "type": "fixed"
}
```
Platforms should send as many information as possible.
If any information is not available, the field should be omitted.
The definition of the fields above are influenced by [IWG1](https://archive.eol.ucar.edu/raf/Software/iwgadts/IWG1_Def.html) and should be kept consistent with that definition if possible.

`type` can be set to "fixed" to indicate that the platform is not intended to move.
