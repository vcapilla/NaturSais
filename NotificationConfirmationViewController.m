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
    _lblLocalizador.text = [NSString stringWithFormat:@"Localizador: %@", [NSString stringWithString:_strLocalizador]];
    
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
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Guardar en Calendario" message:@"Desea guardar este evento en el calendario?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
    [alert show];
    
 
}


-(void)saveInCalendar{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:{
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = [NSString stringWithFormat:@"Cita en NaturSais %@ %@", _strTitle, [NSString stringWithString:_strLocalizador]];
            event.startDate = onlyDate; //today
            event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
            event.notes = [NSString stringWithFormat:@"El localizador de su reserva es: %@", [NSString stringWithString:_strLocalizador]];
            event.location = @"Carrer del Pont, 1 Baixos 43205 Reus (Tarragona)";
            [event setCalendar:[store defaultCalendarForNewEvents]];
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            NSLog(@"Se han guardado los datos en el calendario");
            //NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
            break;
        }
        
        case EKAuthorizationStatusDenied:{
            [self displayAccessDenied];
            break;
        }
        
        case EKAuthorizationStatusNotDetermined:{
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if(granted){
                    EKEvent *event = [EKEvent eventWithEventStore:store];
                    event.title = [NSString stringWithFormat:@"Cita en NaturSais %@ %@", _strTitle, [NSString stringWithString:_strLocalizador]];
                    event.startDate = onlyDate; //today
                    event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
                    event.notes = [NSString stringWithFormat:@"El localizador de su reserva es: %@", [NSString stringWithString:_strLocalizador]];
                    event.location = @"Carrer del Pont, 1 Baixos 43205 Reus (Tarragona)";
                    [event setCalendar:[store defaultCalendarForNewEvents]];
                    NSError *err = nil;
                    [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    NSLog(@"Se han guardado los datos en el calendario");
                    //NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
                } else {
                    [self displayAccessDenied];
                }
            }];
            break;
        }
        case EKAuthorizationStatusRestricted:{
            [self displayAccessRestricted];
            break;
        }
        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"No guardar evento en el calendario");
    }
    if (buttonIndex == 1)
    {
        NSLog(@"Guardar el evento");
        
        [self saveInCalendar];
        
    }
    NSLog(@"Volvemos al principio");
    
       [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void) displayMessage:(NSString *)paramMessage title:(NSString *)title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:paramMessage
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}
- (void) displayAccessDenied{
    [self displayMessage:@"El acceso al calendario a sido denegado, compruebe su configuracion de privacidad" title:@"Acceso denegado"];
}
- (void) displayAccessRestricted{
    [self displayMessage:@"El acceso al calendaro esta restrigido, compruebe sus ajustes" title:@"Acceso restringido"];
}@end
