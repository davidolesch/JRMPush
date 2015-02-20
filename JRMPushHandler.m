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
    NSString *targetName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    if ([userInfo objectForKey:@"url"] == nil) {
        [[[UIAlertView alloc] initWithTitle:targetName message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:targetName message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"View", nil] show];
    }
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
