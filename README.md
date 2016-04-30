SMAUpdatesAvailable
=====================================
![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/SMAUpdatesAvailable/badge.png)
![Badge w/ Version](https://cocoapod-badges.herokuapp.com/p/SMAUpdatesAvailable/badge.png)

This library is an easy to use way to check if there are updates available for your application on the iOS App Store.

#RELEASE 1.0
This is the first iteration of this library and has all of the basic functionality to call out to Apple's lookup service and return the current data for your app. This means that your app must be approved and active in the App Store for this to work. Failsafes are built in at every step to return NO for updates available if anything were to change or not get returned correctly. This way you should be safe and comfortable putting the checks in without accidentally prompting the user to update.

#Example
##objective-c##
``` objective-c
[SMAUpdatesAvailable checkForUpdatesWithType:SMAVersionTypeMajorMinorBug onCompletion:^(SMAUpdateResponse *response) {
    if (response.updateAvailable) {
        // safe to prompt user to update your app
    } else {
        // no updates available 
    }
}];
```

The `SMAUpdateResponse` object contains all of the data used to check for the update. You can query the response and parse the data yourself if you like.

``` objective-c
response.appVersion // current version of your app as reported by MainBundle
response.appStoreVersion // current version of your app as reported by Apple's lookup service (if returned)
response.updateAvailable // BOOL to quickly determine if update is available for your app
response.rawData // NSDictionary of the full response returned by Apple's lookup service (has a lot of Store information)
response.error // error returned in the event of failures at any point and can be helpful for user messages if needed
```

#Installation
* `#import "SMAUpdatesAvailable.h"` where you want to check for updates
* `pod install SMAUpdatesAvailable`
* Copy source files to your project. Only `SMAUpdatesAvailable` and `SMAUpdateResponse` are required

##Requirements
SMAUpdatesAvailable requires [iOS 8.0] or later. We will be working to make this availble to as many versions as we can after proper testing.

##Credits
SMAUpdatesAvailable was written for use in projects created by [Simply Made Apps](https://www.simpleinout.com) so we could help users update to the latest version of our apps.

##Creator
[Bill Burgess](https://github.com/billburgess) [@billburgess](https://twitter.com/billburgess)

##License
SMAUpdatesAvailable is available under the MIT license. See the LICENSE file for more information.

##What's Next
* Testing that this works on older versions of iOS so we can safely add older versions of iOS.
* Add support for Mac App Store updates.
* Native/better support for Swift. Most of this is in place now, but a Swift branch would avoid bridginge headers.
* Mocking library to round out the tests surrounding my network calls and getting data from the main bundle.
* We welcome any pull requests or suggestions for this library.
