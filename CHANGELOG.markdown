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
