//
//  LCAPIClient.h
//  LoginCounter
//
//  Created by Andy Lee on 2/19/13.
//  Copyright (c) 2013 Andy Lee. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void(^CompletionHandler)(NSURLRequest *request, NSURLResponse *response, NSDictionary *results);

@interface LCAPIClient : AFHTTPClient

+ (LCAPIClient *)sharedClient;

- (id)initWithBaseURL:(NSURL *)url;

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completionHandler:(CompletionHandler)completionHandler;

- (void)addUsername:(NSString *)username andPassword:(NSString *)password completionHandler:(CompletionHandler)completionHandler;

@end
