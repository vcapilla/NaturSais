//
//  ContactView.h
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactView : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong)IBOutlet UIButton *webButon;
@property (nonatomic, strong)IBOutlet UIButton *mailButton;
@property (nonatomic, strong)IBOutlet UIButton *phoneButton;
@property (nonatomic, strong)IBOutlet UIButton *mapButton;
@property (nonatomic, strong)IBOutlet UILabel *versonLabel;


-(IBAction)linkButtonClick:(id)sender;
-(IBAction)phoneNumberClick:(id)sender;
-(IBAction)mailClick:(id)sender;
-(IBAction)mapClick:(id)sender;
-(IBAction)parcappClick:(id)sender;
@end
