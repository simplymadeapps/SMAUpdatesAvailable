//
//  SMAUpdatesAvailable.h
//  FrontDesk
//
//  Created by Bill Burgess on 4/27/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAUpdateResponse.h"

typedef NS_ENUM(NSUInteger, SMAVersionType) {
    SMAVersionTypeDefault = 0,
    SMAVersionTypeMajor = 1,
    SMAVersionTypeMajorMinor = 2,
    SMAVersionTypeMajorMinorBug = 3
};

typedef void (^SMAUpdateCompletionBlock)(SMAUpdateResponse * _Nonnull response);

@interface SMAUpdatesAvailable : NSObject

+ (void)checkForUpdatesWithType:(SMAVersionType)type onCompletion:(SMAUpdateCompletionBlock _Nullable)completionBlock;
- (void)checkForUpdatesWithType:(SMAVersionType)type onCompletion:(SMAUpdateCompletionBlock _Nullable)completionBlock;
- (nullable NSString *)bundleIdentifier;
- (nullable NSString *)versionString;
- (BOOL)updateAvailableForCurrentVersion:(nullable NSString *)appVersion andAppStoreVersion:(nullable NSString *)appStoreVersion withType:(SMAVersionType)type;
- (nullable NSString *)cleanupString:(nonnull NSString *)string forType:(SMAVersionType)type;

@end
