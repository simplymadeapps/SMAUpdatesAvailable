//
//  SMAUpdatesAvailable_Tests.m
//  SMAUpdatesAvailable-Tests
//
//  Created by Bill Burgess on 4/29/16.
//
//

#import <XCTest/XCTest.h>
#import "SMAUpdatesAvailable.h"

@interface SMAUpdatesAvailable_Tests : XCTestCase

@end

@implementation SMAUpdatesAvailable_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectInit {
    SMAUpdatesAvailable *ua = [[SMAUpdatesAvailable alloc] init];
    XCTAssertNotNil(ua, @"Object should not be nil");
}

@end
