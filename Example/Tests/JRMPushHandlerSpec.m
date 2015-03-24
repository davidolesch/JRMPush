#import <Foundation/Foundation.h>
#import <JRMPushHandler.h>
#import "JRMPushHandler+Testing.h"

SpecBegin(JRMPushHandler)

__block JRMPushHandler *pushHandler;
__block OCMockObject *mock;

describe(@"Push Handler", ^{
    
    beforeEach(^{
        pushHandler = [[JRMPushHandler alloc] init];
        mock = [OCMockObject partialMockForObject:pushHandler];
    });
    
    it(@"shows an alert view when it is asked to handle a push with an alert", ^{
        [[mock expect] showAlertWithMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:[OCMArg any]];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}}];
    });
    
    it(@"shows a View button in the alert when the push includes a url", ^{
        [[mock expect] showAlertWithMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:@[@"View"]];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}, @"url": @"http://example.com"}];
    });
    
    it(@"doesn't show any additional buttons in the alert when the push doesn't include a url", ^{
        [[mock expect] showAlertWithMessage:[OCMArg isKindOfClass:[NSString class]] andOtherButtonTitles:nil];
        [pushHandler handlePush:@{@"aps": @{@"alert": @"alert string"}}];
    });
    
    afterEach(^{
        [mock verify];
    });
    
});

SpecEnd