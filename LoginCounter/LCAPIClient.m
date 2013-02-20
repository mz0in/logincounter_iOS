//
//  LCAPIClient.m
//  LoginCounter
//
//  Created by Andy Lee on 2/19/13.
//  Copyright (c) 2013 Andy Lee. All rights reserved.
//

#import "LCAPIClient.h"
#import "AFHTTPRequestOperation.h"

NSString * const lcBaseURLString = @"http://powerful-mountain-2209.herokuapp.com/";

@implementation LCAPIClient

+ (LCAPIClient *)sharedClient {
    static LCAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:lcBaseURLString]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self setDefaultHeader:@"Accept" value:@"text/html"];
    self.parameterEncoding = AFJSONParameterEncoding;
    return self;
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password completionHandler:(CompletionHandler)completionHandler{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"user",
                            password, @"password"
                            , nil];
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:@"/users/login" parameters:params];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation,
       id responseObject) {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:kNilOptions error:&error];
         dispatch_async(dispatch_get_main_queue(), ^{
             completionHandler(operation.request, operation.response, json);
         });
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error: %@", [operation error]);
     }];
    
    //call start on your request operation
    [operation start];
}

- (void)addUsername:(NSString *)username andPassword:(NSString *)password completionHandler:(CompletionHandler)completionHandler{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"user",
                            password, @"password"
                            , nil];
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:@"/users/add" parameters:params];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation,
       id responseObject) {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:kNilOptions error:&error];
         dispatch_async(dispatch_get_main_queue(), ^{
             completionHandler(operation.request, operation.response, json);
         });
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error: %@", [operation error]);
     }];
    
    //call start on your request operation
    [operation start];
}
@end