//
//  SMAUpdatesAvailable.m
//  FrontDesk
//
//  Created by Bill Burgess on 4/27/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

#import "SMAUpdatesAvailable.h"

NSString * const lookupURL = @"http://itunes.apple.com/lookup";

@implementation SMAUpdatesAvailable

+ (void)checkForUpdatesWithType:(SMAVersionType)type onCompletion:(SMAUpdateCompletionBlock)completionBlock {
    SMAUpdatesAvailable *ua = [[SMAUpdatesAvailable alloc] init];
    [ua checkForUpdatesWithType:type onCompletion:completionBlock];
}

- (void)checkForUpdatesWithType:(SMAVersionType)type onCompletion:(SMAUpdateCompletionBlock)completionBlock {
    SMAUpdateResponse *response = [[SMAUpdateResponse alloc] init];
    
    NSString *bundleIdentifier = [self bundleIdentifier];
    if (bundleIdentifier && bundleIdentifier.length > 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?bundleId=%@", lookupURL, bundleIdentifier]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *parseError;
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        response.appVersion = [self versionString];
        response.rawData = responseData; // return the raw response if any
        
        if ([responseData[@"resultCount"] integerValue] == 1) {
            NSLog(@"update response data: %@", responseData);
            NSArray *results = responseData[@"results"];
            if (results && results.count > 0) {
                NSString *appStoreVersion = results[0][@"version"];
                if (appStoreVersion) {
                    response.appStoreVersion = appStoreVersion;
                    response.updateAvailable = [self updateAvailableForCurrentVersion:response.appVersion andAppStoreVersion:response.appStoreVersion withType:type];
                } else {
                    response.error = [NSError errorWithDomain:@"SMAUpdatesAvailable" code:1 userInfo:@{@"message": @"Unable to get current App Store version."}];
                }
            } else {
                response.error = [NSError errorWithDomain:@"SMAUpdatesAvailable" code:2 userInfo:@{@"message": @"Unable to parse results."}];
            }
        } else {
            NSLog(@"no response data from Apple");
            response.updateAvailable = NO; // unable to safely determine if app update is available
            if (parseError) {
                response.error = parseError;
            }
        }
    } else {
        response.error = [NSError errorWithDomain:@"SMAUpdatesAvailable" code:0 userInfo:@{@"message": @"Unable to find bundleIdentifier for this application."}];
    }
    
    if (completionBlock) {
        completionBlock(response);
    }
}

- (NSString *)bundleIdentifier {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return dict[@"CFBundleIdentifier"];
}

- (NSString *)versionString {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return dict[@"CFBundleShortVersionString"];
}

- (BOOL)updateAvailableForCurrentVersion:(NSString *)appVersion andAppStoreVersion:(NSString *)appStoreVersion withType:(SMAVersionType)type {
    if (!appVersion || !appStoreVersion) {
        // unable to compare versions
        return NO;
    }
    
    appVersion = [self cleanupString:appVersion ForType:type];
    appStoreVersion = [self cleanupString:appStoreVersion ForType:type];
    
    if ([appStoreVersion compare:appVersion options:NSNumericSearch] == NSOrderedDescending) {
        return YES; // version is less than app store version
    } else {
        return NO;
    }
}

- (NSString *)cleanupString:(nonnull NSString *)string ForType:(SMAVersionType)type {
    if (!type || type == SMAVersionTypeDefault || !string) {
        return string;
    }
    
    NSString *returnString;
    NSArray *comps = [string componentsSeparatedByString:@"."];
    if (!comps) {
        return string;
    }
    
    switch (type) {
        case SMAVersionTypeMajor: {
            if (comps.count > 0) {
                returnString = [comps firstObject];
            }
            break;
        }
        case SMAVersionTypeMajorMinor: {
            if (comps.count > 1) {
                returnString = [NSString stringWithFormat:@"%@.%@", comps[0], comps[1]];
            } else {
                returnString = string;
            }
            break;
        }
        case SMAVersionTypeMajorMinorBug: {
            if (comps.count > 2) {
                returnString = [NSString stringWithFormat:@"%@.%@.%@", comps[0], comps[1], comps[2]];
            } else {
                returnString = string;
            }
            break;
        }
        case SMAVersionTypeDefault:
        default: {
            returnString = string;
            break;
        }
    }
    
    return returnString;
}

@end
