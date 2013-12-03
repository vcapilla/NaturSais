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

@property(nonatomic, strong) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSDate *selectedDate;

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
    
    CKCalendarView *calendar = [[CKCalendarView alloc]initWithStartDay:startMonday frame:CGRectMake(35, 60, 250, 250)];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    today = [NSDate date];
    NSDate *minDate = [today dateByAddingTimeInterval:-3600*1000];
    self.minimumDate = minDate;
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.backgroundColor = [UIColor colorWithRed:(28/255.0) green:(145/255.0) blue:(41/255.0) alpha:(200/255.0)];
    [self.view addSubview:calendar];
    //Le decimos al DatePicker que la fecha minima es hoy.
    //NSDate *today = [NSDate date];
    //_date.minimumDate = today;
    
    self.navigationItem.title = @"Reservar";    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    NSInteger intervalo = (NSInteger)[date timeIntervalSinceNow];
    NSInteger fecha = (NSInteger)date;
    NSString *hoyString = [self.dateFormatter stringFromDate:today];
    NSDate *hoyDate = [self.dateFormatter dateFromString:hoyString];
    
    NSLog(@"%d", intervalo);
    if ([date compare:hoyDate]==NSOrderedAscending){
        if([date compare:hoyDate]==NSOrderedSame){
            NSLog(@"%d", fecha);
            return NO;
        }else{
            return YES;
        }
    }
    
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor =[UIColor colorWithRed:230 green:230 blue:230 alpha:0];
        dateItem.textColor =[UIColor grayColor];
        
    }
}


- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    _selectedDate = date;
    NSString *fechaSeleccionada = [self.dateFormatter stringFromDate:date];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Fecha seleccionada" message:[NSString stringWithFormat:@"La fecha seleccionada es:%@", fechaSeleccionada] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
    
}

//Metodo que se lanza al pulsar el boton de Reservar, debajo del calendario de seleccion.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Identificamos el segue por si hemos puesto 2
    if([segue.identifier isEqualToString:@"sendDate"]){
        
        //Seleccionamos la fecha que hay en ese momento en el calendario
        NSDate *selectedDate = _selectedDate;
        
        //creamos un objeto de formato para darle formato a la fecha
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"ddMMyy"];
        
        //creamos un objeto de la clase FreeHour que es la clase de destino de la transicion
        FreeHours *destination = segue.destinationViewController;
        
        //Convertimos el formato Date a formato String
        NSString *formatedCode = [formatter stringFromDate:selectedDate];
        
        //guardamos el string con la fecha obtenida en el objeto code de la clase de destino
        destination.code = formatedCode;
        
        //Indicamos que una vez pasemos a la siguiente pantalla la barra de pestañas no aparezca
        destination.hidesBottomBarWhenPushed = YES;
        
       
    }
}

@end
