//
//  SMAUpdateResponse.h
//  FrontDesk
//
//  Created by Bill Burgess on 4/27/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMAUpdateResponse : NSObject

@property (nonatomic, strong, nullable) NSString *appVersion;
@property (nonatomic, strong, nullable) NSString *appStoreVersion;
@property (nonatomic, assign) BOOL updateAvailable;
@property (nonatomic, strong, nullable) NSDictionary *rawData;
@property (nonatomic, strong, nullable) NSError *error;

@end
