#import <Foundation/Foundation.h>
#import <JRMPushHandler.h>
#import "JRMPushHandler+Testing.h"

SpecBegin(JRMPushHandler)

__block JRMPushHandler *pushHandler;

describe(@"Alert View", ^{
    it(@"is shown with the push string as its message", ^{
        id mockAlertView = [OCMockObject mockForClass:[UIAlertView class]];
        [[[mockAlertView stub] andReturn:mockAlertView] alloc];
        (void)[[[mockAlertView expect] andReturn:mockAlertView] initWithTitle:OCMOCK_ANY message:@"alert string" delegate:OCMOCK_ANY cancelButtonTitle:OCMOCK_ANY otherButtonTitles:OCMOCK_ANY, nil];
        [[mockAlertView expect] show];
        
        pushHandler = [[JRMPushHandler alloc] init];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}}];
        
        [mockAlertView verify];
        [mockAlertView stopMocking];
    });
});


__block OCMockObject *mock;

describe(@"Push Handler", ^{
    
    beforeEach(^{
        pushHandler = [[JRMPushHandler alloc] init];
        mock = [OCMockObject partialMockForObject:pushHandler];
    });
    
    it(@"creates an alert view when it is asked to handle a push with an alert", ^{
        [[mock expect] alertViewForMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:[OCMArg any]];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}}];
    });
    
    it(@"includes a View button in the alert when the push includes a url", ^{
        [[mock expect] alertViewForMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:@[@"View"]];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}, @"url": @"http://example.com"}];
    });
    
    it(@"doesn't include any additional buttons in the alert when the push doesn't include a url", ^{
        [[mock expect] alertViewForMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:nil];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}}];
    });
    
    afterEach(^{
        [mock verify];
    });
    
});

SpecEnd