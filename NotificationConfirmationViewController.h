//
//  notificationConfirmationViewController.h
//  NaturSais
//
//  Created by Victor Capilla on 24/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationConfirmationViewController : UIViewController

@property (nonatomic, strong)IBOutlet UILabel *lblTitle;
@property (nonatomic, strong)IBOutlet UILabel *lblName;
@property (nonatomic, strong)IBOutlet UILabel *lblPhone;
@property (nonatomic, strong)IBOutlet UILabel *lblComents;
@property (nonatomic ,strong)NSString *strTitle;
@property (nonatomic ,strong)NSString *strName;
@property (nonatomic ,strong)NSString *strPhone;
@property (nonatomic ,strong)NSString *strComents;

-(IBAction)endProcess:(id)sender;

@end