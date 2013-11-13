//
//  BookingView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "BookingView.h"
#import "FreeHours.h"


@interface BookingView ()

@end
//Pantalla de seleccion de fecha
@implementation BookingView

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
    
    //Le decimos al DatePicker que la fecha minima es hoy.
    NSDate *today = [NSDate date];
    _date.minimumDate = today;
    
    self.navigationItem.title = @"Reservar";    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Metodo que se lanza al pulsar el boton de Reservar, debajo del calendario de seleccion.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Identificamos el segue por si hemos puesto 2
    if([segue.identifier isEqualToString:@"sendDate"]){
        
        //Seleccionamos la fecha que hay en ese momento en el calendario
        NSDate *selectedDate = [self.date date];
        
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
