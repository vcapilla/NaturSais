//
//  BookingView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "BookingView.h"
#import "FreeHours.h"
#import <CoreGraphics/CoreGraphics.h>

#import "CKCalendarView.h"

@interface BookingView () <CKCalendarDelegate>

@property(nonatomic, strong) NSDate *selectedDate;
@property(nonatomic, strong) CKCalendarView *calendar;

@end

//Pantalla de seleccion de fecha
@implementation BookingView{

    NSDate *today;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIImage *logo = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView =[[UIImageView alloc] initWithImage:logo];
    CKCalendarView *calendar = [[CKCalendarView alloc]initWithStartDay:startMonday frame:CGRectMake(10, 100, 300, 300)];
    self.calendar = calendar;
    calendar.delegate = self;
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    calendar.backgroundColor = [UIColor clearColor];
     
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
    

    
    [self.view addSubview:calendar];

    _info.backgroundColor = [UIColor clearColor];

}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"ddMMyy"];
    
    NSString *hoyString = [formatter stringFromDate:[NSDate date]];
    NSDate *hoyDate = [formatter dateFromString:hoyString];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [cal components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger dayOfWeek = [comp weekday];
    
    BOOL esmayor = [date timeIntervalSinceNow]>0.0;
    BOOL eshoy = [date isEqual:hoyDate];
    
    
    if (dayOfWeek == 7 || dayOfWeek == 1) {
        return YES;
    }else if (esmayor || eshoy){
            return NO;
            
        }else{
            
            return YES;
            
        }
        
    }
    
-(void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date{
    if([self dateIsDisabled:date]){
        dateItem.backgroundColor = [UIColor clearColor];
        dateItem.textColor = [UIColor colorWithRed:(119/250.0) green:(119/250.0) blue:(119/250.0) alpha:(250/250.0)];
        
    }
}

-(BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date{
    
    return ![self dateIsDisabled:date];
    
}

-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date{
    _selectedDate = date;
    [self performSegueWithIdentifier:@"sendDate" sender:self];
}

////Metodo que se lanza al pulsar el boton de Reservar, debajo del calendario de seleccion.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Identificamos el segue por si hemos puesto 2
    if([segue.identifier isEqualToString:@"sendDate"]){
        
        
        
        
        
        //creamos un objeto de formato para darle formato a la fecha
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"ddMMyy"];
        
        //creamos un objeto de la clase FreeHour que es la clase de destino de la transicion
        FreeHours *destination = segue.destinationViewController;
        
        //Convertimos el formato Date a formato String
        NSString *formatedCode = [formatter stringFromDate:_selectedDate];
        
        //guardamos el string con la fecha obtenida en el objeto code de la clase de destino
        destination.code = formatedCode;

       
    }else if([segue.identifier isEqualToString:@"mostrarHorarios"]){
        
    }
    
}

@end
