//
//  Horarios.m
//  NaturSais
//
//  Created by Victor Capilla on 30/01/14.
//  Copyright (c) 2014 ParcApp. All rights reserved.
//

#import "Horarios.h"

@interface Horarios ()

@end

@implementation Horarios

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
    UIImage *backgroundImage = [[UIImage alloc] init];
    
    if([[UIScreen mainScreen]bounds].size.height == 568)
    {
        backgroundImage = [UIImage imageNamed:@"fondo-568h"];
    }
    else
    {
        backgroundImage = [UIImage imageNamed:@"fondo"];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
