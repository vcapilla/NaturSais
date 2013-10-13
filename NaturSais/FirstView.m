//
//  FirstView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "FirstView.h"

@interface FirstView ()

@end

@implementation FirstView

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
//    UIImage *imageView = [[UIImage alloc]init];
//    
//    BOOL isIPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
//    BOOL isIPhone5 = isIPhone && ([[UIScreen mainScreen] bounds].size.height > 480.0);
//    if (isIPhone5) {
//        
//        imageView = [UIImage imageNamed:@"background_iphone5.png"];
//        self.view.backgroundColor = [UIColor colorWithPatternImage:imageView];
//        
//    } else {
//        
//        imageView = [UIImage imageNamed:@"background_iphone4sretina.png"];
//        self.view.backgroundColor = [UIColor colorWithPatternImage:imageView];
//        
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
