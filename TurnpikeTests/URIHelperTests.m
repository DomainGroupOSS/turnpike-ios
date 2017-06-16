//
//  URIHelperTests.m
//  Turnpike
//
//  Created by James Lawrence Turner on 7/17/13.
//  Copyright (c) 2013 URX. All rights reserved.
//

#import "URIHelperTests.h"
#import "TPURIHelper.h"

@implementation URIHelperTests

-(void) assertString:(NSString *)inputString EqualsScheme:(NSString *)scheme Path:(NSString *)path AndQuery:(NSString *)query {
    NSURL *outputURL = [TPURIHelper sanitizeString:inputString];
    NSString *outputScheme = [TPURIHelper safeSchemeFromURL:outputURL];
    
    XCTAssertEqualObjects(scheme,outputScheme, @"should be equal to the test scheme");
    XCTAssertEqualObjects(path, outputURL.path, @"should be equal to the test path");
    XCTAssertEqualObjects(query, outputURL.query, @"should be equal to the test query");
}

-(void) testSanitizeStringWithEmptyRootPath {
    [self assertString:@"" EqualsScheme:nil Path:nil AndQuery:nil];
}

@end
