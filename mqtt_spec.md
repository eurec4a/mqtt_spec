# EUREC4A MQTT broker message specification

## General

The [EUREC4A](https://www.eurec4a.eu) MQTT broker is intended to exchange various pieces of live information during the EUREC4A field campaign.

## Messages
All messages are encoded as JSON. Timestamps are given in UTC and encoded according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). Any physical quantities must be given in terms of the appropriate [SI base units](https://en.wikipedia.org/wiki/SI_base_unit) if not designated otherwise.

### Platforms
Platforms are assets which may move independently throughout the world.
This includes ships, aircraft, drones, gliders, drifter, balloons and so on.
Platforms are identified by a unique `<platform id>`.
Each platform gets its own namespace unter `platform/<platform id>`.
A platform MUST publish a retained message containing a general description of itself under `platform/<platform id>/meta`.
The contents of this message are as follows:
```json
{
    "long_name": "<full name of the platform>",
    "platform_types": ["list", "of types characterizing the platform", "in decending oder of specificity"],
    "url": "<web link for more information about the platform>",
    "contact": {
        "name": "<name of contact>",
        "email": "<email of contact>"
    }
}
```
Platforms should send as many information as possible.
If any information is not available, the field should be ommitted.

Each platform SHOULD publish messages identifyig its location.
The contents of this message are as follows:
```json
{
    "time": "<time of position acquisition>",
    "lat": "<latitude in decimal WGS84 coordinates, degrees, north positive>",
    "lon": "<longitude in decimal WGS84 coordinates, degrees, east positive>",
    "heading": "<clockwise heading of the platform, degrees, north is 0>",
    "ground_speed": "<platform speed over ground, unit: m/s>",
    "press_alt": "<pressure altitude, unit: hPa>",
    "gps_msl_alt": "<altitude in WGS84 coordinates, unit: m>",
    "vert_velocity": "<vertical velocity, unit: m/s>"
}
```
Platforms should send as many information as possible.
If any information is not available, the field should be ommitted.
