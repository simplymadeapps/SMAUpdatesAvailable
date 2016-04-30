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

@property (nonatomic, strong) SMAUpdatesAvailable *ua;

@end

@implementation SMAUpdatesAvailableTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.ua = [[SMAUpdatesAvailable alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.ua = nil;
    
    [super tearDown];
}

- (void)testObjectInitNotNil {
    SMAUpdatesAvailable *update = [[SMAUpdatesAvailable alloc] init];
    XCTAssertNotNil(update);
}

- (void)testUpdateNotAvailableWithNilValues {
    BOOL available = [self.ua updateAvailableForCurrentVersion:nil andAppStoreVersion:nil withType:SMAVersionTypeDefault
                      ];
    XCTAssertFalse(available);
}

- (void)testUpdateAvailableForDefaultType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.2.3.5";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeDefault];
    XCTAssertTrue(available);
}

- (void)testUpdateNotAvailableForDefaultType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.2.3.3";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeDefault];
    XCTAssertFalse(available);
}

- (void)testUpdateAvailableForMajorType {
    NSString *appVersion = @"1.2";
    NSString *storeVersion = @"2";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajor];
    XCTAssertTrue(available);
}

- (void)testUpdateNotAvailableForMajorType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.3";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajor];
    XCTAssertFalse(available);
}

- (void)testUpdateAvailableForMajorMinorType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.3";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajorMinor];
    XCTAssertTrue(available);
}

- (void)testUpdateNotAvailableForMajorMinorType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.2.4";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajorMinor];
    XCTAssertFalse(available);
}

- (void)testUpdateAvailableForMajorMinorBugType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.2.4";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajorMinorBug];
    XCTAssertTrue(available);
}

- (void)testUpdateNotAvailableForMajorMinorBugType {
    NSString *appVersion = @"1.2.3.4";
    NSString *storeVersion = @"1.2.3.5";
    
    BOOL available = [self.ua updateAvailableForCurrentVersion:appVersion andAppStoreVersion:storeVersion withType:SMAVersionTypeMajorMinorBug];
    XCTAssertFalse(available);
}

- (void)DISABLED_testBundleIdentifierReturnsString {
    NSString *bundleId = [self.ua bundleIdentifier];
    XCTAssertNotNil(bundleId);
}

- (void)DISABLED_testVersionStringReturnsString {
    NSString *version = [self.ua versionString];
    XCTAssertNotNil(version);
}

- (void)testStringCleanupWorksForDefaultType {
    NSString *version = @"1.2.3.4";
    NSString *value = [self.ua cleanupString:version forType:SMAVersionTypeDefault];
    
    XCTAssertEqualObjects(value, version);
}

- (void)testStringCleanupWorksForMajorType {
    NSString *version = @"1.2.3.4";
    NSString *value = [self.ua cleanupString:version forType:SMAVersionTypeMajor];
    
    XCTAssertEqualObjects(value, @"1");
}

- (void)testStringCleanupWorksForMajorMinorType {
    NSString *version = @"1.2.3.4";
    NSString *value = [self.ua cleanupString:version forType:SMAVersionTypeMajorMinor];
    
    XCTAssertEqualObjects(value, @"1.2");
}

- (void)testStringCleanupWorksForMajorMinorBugType {
    NSString *version = @"1.2.3.4";
    NSString *value = [self.ua cleanupString:version forType:SMAVersionTypeMajorMinorBug];
    
    XCTAssertEqualObjects(value, @"1.2.3");
}

- (void)testStringCleanupReturnsStringForInvalidFormats {
    NSString *invalid = @"1,2,3";
    NSString *value = [self.ua cleanupString:invalid forType:SMAVersionTypeMajor];
    XCTAssertEqualObjects(invalid, value);
    
    invalid = @"";
    value = [self.ua cleanupString:invalid forType:SMAVersionTypeMajor];
    
    XCTAssertEqualObjects(invalid, value);
}

- (void)testStringCleanupWithTruncatedStrings {
    NSString *version = @"1";
    NSString *value = [self.ua cleanupString:version forType:SMAVersionTypeMajorMinor];
    XCTAssertEqualObjects(value, version);
    
    version = @"1.2";
    value = [self.ua cleanupString:version forType:SMAVersionTypeMajorMinorBug];
    XCTAssertEqualObjects(value, version);
}

@end
