//
//  SMAUpdatesAvailableTests.m
//  SMAUpdatesAvailable
//
//  Created by Bill Burgess on 4/29/16.
//
//

#import <XCTest/XCTest.h>
#import "SMAUpdatesAvailable.h"

@interface SMAUpdatesAvailableTests : XCTestCase

@end

@implementation SMAUpdatesAvailableTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectInitNotNil {
    SMAUpdatesAvailable *update = [[SMAUpdatesAvailable alloc] init];
    XCTAssertNotNil(update);
}

@end
