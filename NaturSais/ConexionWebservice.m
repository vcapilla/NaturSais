//
//  ConexionWebservice.m
//  NaturSais
//
//  Created by Victor Capilla on 08/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "ConexionWebservice.h"
#import "AFJSONRequestOperation.h"
#import "JSONKit.h"

static NSString *const BaseURLString = @"http://natursais.tk/testservice.php";

@implementation ConexionWebservice{
    NSMutableArray *codeArray;
    
    }

-(id)webserviceAccess:(NSString *)method code:(NSString *)code{
    
    
    NSString *webserviceUrl = [NSString stringWithFormat:@"%@?method=%@&code=%@", BaseURLString, method, code];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([JSON isEqual:[NSNull null]]) {
            NSLog(@"The JSON is empty");
        }else{
           
            NSArray *savedJSON = [self arrayFromJson:JSON];
            codeArray = [NSMutableArray arrayWithArray:[savedJSON valueForKey:@"code"]];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                     message:[NSString stringWithFormat:@"%@",error]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [av show];
    }];
    
    [op start];
    
return codeArray;

}
-(void)webserviceAccess:(NSString *)method code:(NSString *)code hora:(NSString *)hora{
    
    NSString *webserviceUrl = [[NSString stringWithFormat:@"%@?method=%@&code=%@&hora=%@", BaseURLString, method, code, hora] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFJSONRequestOperation *op =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSLog(@"El JSON es del tipo %@", [JSON class]);                                                                                                            }
     
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        NSLog(@"%@",error);
                                                        [av show];
                                                        
                                                    }];
    
    op.JSONReadingOptions = NSJSONReadingAllowFragments;
    [op start];
    
}

-(void)webserviceAccess:(NSString *)method code:(NSString *)code name:(NSString *)name phone:(NSString *)phone comments:(NSString *)comments{
  
    NSString *webserviceURL = [[NSString stringWithFormat:@"%@?method=%@&code=%@&nombre=%@&telefono=%@&comentarios=%@", BaseURLString, method, code, name, phone, comments]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    NSURL *url = [NSURL URLWithString:webserviceURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operationDeshacer = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *respones, id JSON){
        NSLog(@"%@", [JSON class]);
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                     message:[NSString stringWithFormat:@"%@",error]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
       
        [av show];
        
    }];
    operationDeshacer.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operationDeshacer start];
    
}

-(NSArray *)arrayFromJson:(NSString *) JSONString {
    JSONDecoder * decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    return [decoder mutableObjectWithData:[JSONString JSONData]];
}
@end

