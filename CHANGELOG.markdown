## 1.7.0

- Added support for watchOS 2
- SGHTTPRequest is now based on AFNetworking 3
- Reduced default disk cache size to 20MB
- Moved disk cache location to new folder
- Added some unit tests and continuous integration with Travis CI

## 1.6.0

- New SGHTTPLogCache flag to enable / disable ETag cache flushing debug logs
- New disk cache backend

## 1.5.0

- Added upload and download progress blocks for easy upload and download handling
- Improved disk cache performance

## 1.4.1

- Optimized ETag cache flushing
- Added a way to flag cached requests to not be purged when the cache is getting full

## 1.4.0

- Added the option to disallow NSNull objects in JSON responses

## 1.3.0

- Added support for multipart post requests
- Added the ability to set time-to-expire manually per http request object
- Added the ability to load cached SGHTTPRequest responses
- Fixed a race condition
- Made ETag handling more reliable for servers which don't reliably send ETags

## 1.2.0

- Added HTTP ETag support and persistent response caching
- More detailed response and error logging
- Added PATCH support

## 1.1.1

- Wrap up non-app extension compatible code in an SG_APP_EXTENSIONS macro
- Specify minimum requirement of AFNetworking 2.0
- Fix potential stability issues if attempting to use an invalid URL, plus a synchronisation issue

## 1.1.0

- Fancy debug error output formatting for readability. Print out request and
  response JSON in pretty format when displaying errors
- Added `responseJSON` helper getter for JSON responses
- Added `requestHeaders` property
- Misc minor bug fixes

## 1.0.2

Added console logging options

## 1.0.1

Fixed a JSON POST data regression

## 1.0.0

Initial release
