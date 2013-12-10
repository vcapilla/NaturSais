//
//  notificationConfirmationViewController.m
//  NaturSais
//
//  Created by Victor Capilla on 24/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//
//Clase que se encarga de controlar la vista donde mostramos la informacion introducida por el usuario

#import <EventKit/EventKit.h>
#import "NotificationConfirmationViewController.h"

@interface NotificationConfirmationViewController ()

@end

@implementation NotificationConfirmationViewController{
    
    NSDate *onlyDate;
    NSString *horaSolo;
}

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
    NSDateFormatter *dateFormatter;
    //Rellenamos las etiquetas con la informacion obtenida de la vista anterior
    _lblName.text = [NSString stringWithString:_strName];
    _lblPhone.text = [NSString stringWithString:_strPhone];
    _lblComents.text = [NSString stringWithString:_strComents];
    _lblTitle.text = [NSString stringWithString:_strTitle];
    self.navigationItem.title = @"Confirmacion de su reserva";
    //No queremos que puedan volver hacia atras porque ya se ha confirmado
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"Fecha y hora:%@", _strDate);
    NSString *fechaSolo = [_strDate substringToIndex:6];
    horaSolo = [_strDate substringWithRange:NSMakeRange(6, 2)];
    NSLog(@"la fecha es %@ y la hora es %@:00", fechaSolo, horaSolo);
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMyyHH"];
    
    onlyDate = [dateFormatter dateFromString:_strDate];
    NSLog(@"la fecha es %@ y la hora es %@:00", fechaSolo, horaSolo);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Al clicar en el boton de OK volvera a la primera vista
-(IBAction)endProcess:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)saveInCalendar:(id)sender{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"Cita en NaturSais %@", _strTitle];
        event.startDate = onlyDate; //today
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
        [event setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        
        //NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
    }];
}
@end
