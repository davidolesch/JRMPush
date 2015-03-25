//
//  JRMPushHandler.m
//  ParseStarterProject
//
//  Created by David Olesch on 2/19/15.
//
//

#import "JRMPushHandler.h"
#import "SVWebViewController.h"

@interface JRMPushHandler () <UIAlertViewDelegate>

@property (strong, nonatomic) NSDictionary *alertViewUserInfo;

@end

@implementation JRMPushHandler

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)handlePush:(NSDictionary *)userInfo
{
    self.alertViewUserInfo = userInfo;
    
    UIAlertView *alertView;
    if ([userInfo objectForKey:@"url"] == nil) {
        alertView = [self alertViewForMessage:userInfo[@"aps"][@"alert"] andOtherButtonTitles:nil];
    }
    else {
        alertView = [self alertViewForMessage:userInfo[@"aps"][@"alert"] andOtherButtonTitles:@[@"View"]];
    }
    [alertView show];
}

- (UIAlertView *)alertViewForMessage:(NSString *)message andOtherButtonTitles:(NSArray *)otherButtonTitles {
    NSString *targetName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:targetName message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    for (NSString *buttonTitle in otherButtonTitles) {
        [alertView addButtonWithTitle:buttonTitle];
    }
    return alertView;
}

- (void)presentWebViewControllerForWebsite:(NSString *)websiteURL
{
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:websiteURL];
    UIViewController *windowRootViewControler = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (windowRootViewControler.presentedViewController != nil) {
        [windowRootViewControler dismissViewControllerAnimated:NO completion:^{
            [windowRootViewControler presentViewController:webViewController animated:YES completion:nil];
        }];
    }
    else {
        [windowRootViewControler presentViewController:webViewController animated:YES completion:nil];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self presentWebViewControllerForWebsite:[self.alertViewUserInfo objectForKey:@"url"]];
    }
}


@end
