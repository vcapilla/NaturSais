//
//  BookingFormViewController.h
//  NaturSais
//
//  Created by Victor Capilla on 17/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingFormViewController : UIViewController
@property (nonatomic, strong)IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)IBOutlet UITextField *name;
@property (nonatomic, strong)IBOutlet UITextField *phone;
@property (nonatomic, strong)IBOutlet UITextField *comments;
@property (nonatomic, strong)NSString *selectedHour;


@end
