# Google Analytics output plugin for Embulk
This plugin performs the data import and measurement protocol into Google Analytis.
However, Measurement Protocol feature is not implemented.

## Overview
* **Plugin type**: output
* **Load all or nothing**: no
* **Resume supported**: no
* **Cleanup supported**: no

## Configuration
- **action**: "dataimport" or "measurement_protocol" (string, default: `"dataimport"`)
- **client_id**: authentication (string, required)
- **client_secret**: authentication (string, required)
- **refresh_token**: authentication (string, required)
- **account_id**: Your google analytics account id (string, required)
- **webproperty_id**: Your google analytics Web Property id (string, required)
- **datasource_id**: Your google analytics Data Source id (string, default: `nil`)
- **filename**: Your upload filename (string, default: `nil`)

## Example

```yaml
out:
  type: google_analytics
  action: dataimport
  client_id: xxxxxxxxx.apps.googleusercontent.com
  client_secret: yyyyyyyyyyyyyyy
  refresh_token: 1/zzzzzzzzzzzzzzzzzzzzz
  account_id: xyz
  webproperty_id: UA-xyz-a
  datasource_id: xxxxxxxxxxxxx
  filename: "Sample Cost Data.csv"
```


## Build

```
$ rake
```
