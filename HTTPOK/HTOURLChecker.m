//
//  HTOURLChecker.m
//  HTTPOK
//
//  Created by Timmy on 15/05/2013.
//  Copyright (c) 2013 Applicious. All rights reserved.
//

#import "HTOURLChecker.h"

#define REQUEST_TIMEOUT 60

@implementation HTOURLChecker

@synthesize delegate, url;

-(void) check {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url ] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: REQUEST_TIMEOUT];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if ( ! connection ) {
        [delegate URLCheckedWithStatus: 404 andURL: url];
    }
    
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
 
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSString *request_url = [[[connection originalRequest] URL] absoluteString];
    [delegate URLCheckedWithStatus: [httpResponse statusCode] andURL: request_url];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    NSString *request_url = [[[connection originalRequest] URL] absoluteString];
    [delegate URLCheckedWithStatus: 404 andURL: request_url];
    
}

-(id) initWithURL:(NSString*) urlStr {
    
    self = [super init];
    if ( self ) {
        url = urlStr;
    }
    
    return self;
    
}

-(id) init {
    
    return [self initWithURL:@""];
    
}

@end