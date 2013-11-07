//
//  ConexionWebservice.h
//  NaturSais
//
//  Created by Victor Capilla on 08/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConexionWebservice : NSObject

-(void)webserviceAccess:(NSString *)method code:(NSString *)code;
-(void)webserviceAccess:(NSString *)method code:(NSString *)code hora:(NSString *)hora;
-(void)webserviceAccess:(NSString *)method code:(NSString *)code name:(NSString *)name phone:(NSString *)phone comments:(NSString *)comments;
-(id)returnWebService:(NSString *)method code:(NSString *)code;
@end
