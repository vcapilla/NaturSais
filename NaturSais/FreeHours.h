//
//  FreeHours.h
//  NaturSais
//
//  Created by Victor Capilla on 10/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeHours : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSString *code;


@end
