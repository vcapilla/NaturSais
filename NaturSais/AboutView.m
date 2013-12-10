//
//  AboutView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "AboutView.h"

@interface AboutView ()

@end

//Pantalla donde aparece una pequeña explicacion de la empresa.

@implementation AboutView

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
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(28/255.0) green:(145/255.0) blue:(41/255.0) alpha:(200/255.0)]];   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
