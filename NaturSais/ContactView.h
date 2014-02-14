//
//  ContactView.h
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)IBOutlet UITableView *tableView;


@end
