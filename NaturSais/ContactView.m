//
//  ContactView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "ContactView.h"

@interface ContactView ()

@end

@implementation ContactView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)linkButtonClick:(id)sender {
    NSString* launchUrl = @"http://www.natursais.com";
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: launchUrl]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder abrir esta web." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
    
    }else{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
        
    }
    
}

-(IBAction)phoneNumberClick:(id)sender{
    
    NSString *phoneNumber = @"teleprompt://608140283";
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: phoneNumber]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder realizar una llamada." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
}

-(IBAction)mailClick:(id)sender{
    
    NSString *mail = @"mailto://parcapp@parcapp.es";
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: mail]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para gestionar el correo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mail]];
}
}
@end
