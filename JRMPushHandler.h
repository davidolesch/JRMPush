//
//  JRMPushHandler.h
//  ParseStarterProject
//
//  Created by David Olesch on 2/19/15.
//
//

#import <Foundation/Foundation.h>

@interface JRMPushHandler : NSObject

+ (instancetype)sharedInstance;

/**
 *  Presents a UIAlertView with the information in the passed userInfo dictionary. A view button will be included in the UIAlertView if a URL is set at userInfo["url"].
 *
 *  @param userInfo A push notification userInfo dictionary containing an alert at userInfo["aps"]["alert"] and optionallly a URL at userInfo["url"].
 */
- (void)handlePush:(NSDictionary *)userInfo;

@end
