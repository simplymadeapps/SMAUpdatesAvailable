//
//  SMAUpdateResponseTests.m
//  SMAUpdatesAvailable
//
//  Created by Bill Burgess on 4/29/16.
//
//

#import <XCTest/XCTest.h>
#import "SMAUpdateResponse.h"

@interface SMAUpdateResponseTests : XCTestCase

@end

@implementation SMAUpdateResponseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectInitNotNil {
    SMAUpdateResponse *response = [[SMAUpdateResponse alloc] init];
    XCTAssertNotNil(response);
}

- (void)testObjectPropertyInitialization {
    SMAUpdateResponse *response = [[SMAUpdateResponse alloc] init];
    XCTAssertNil(response.appVersion);
    XCTAssertNil(response.appStoreVersion);
    XCTAssertFalse(response.updateAvailable);
    XCTAssertNil(response.rawData);
    XCTAssertNil(response.error);
}

@end
