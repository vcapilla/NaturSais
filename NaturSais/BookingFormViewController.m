//
//  BookingFormViewController.m
//  NaturSais
//
//  Created by Victor Capilla on 17/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//
//Clase que se encarga de controlar la vista de rellenar el formulario

#import "BookingFormViewController.h"
#import "FreeHours.h"
#import "NotificationConfirmationViewController.h"

//URL sin envio de mail
//static NSString *const BaseURLString = @"http://natursais.tk/testservice.php";

//URL con envio de mail
static NSString *const BaseURLString = @"http://natursais.tk/natursais_test_service_con_mail/testservice.php";


@interface BookingFormViewController ()

@end

@implementation BookingFormViewController{
    
    //Variables de la implementacion
    NSString *completeHour;
    NSString *insertedName;
    NSString *insertedPhone;
    NSString *insertedComments;

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
   
    //Indicamos que titulo tendra la barra de navegacion
    self.navigationItem.title = @"Fecha solicitada";
    
    //Asignamos el texto a la label
    //_titleLabel.text = [NSString stringWithFormat:@"%@", _selectedHour];
    
    //Asignamos las 2 primeras posiciones del valor obtenido de la vista anterior a la variable dia
    NSString *day = [_selectedHour substringToIndex:2];
    
    //Asignamos el segundo par de numero a la variable Mes numerico
    NSString *numericMonth = [_selectedHour substringWithRange:NSMakeRange(2, 2)];
    
    //Inicializamos la variable mes donde guardaremos el nombre del mes
    NSString *month =[[NSString alloc]init];
    
    //Buscamos el nombre del mes correspondiente al numero
    switch ([numericMonth intValue]) {
        case 1:
            month=@"Enero";
            break;
        case 2:
            month=@"Febrero";
            break;
        case 3:
            month=@"Marzo";
            break;
        case 4:
            month=@"Abril";
            break;
        case 5:
            month=@"Mayo";
            break;
        case 6:
            month=@"Junio";
            break;
        case 7:
            month=@"Julio";
            break;
        case 8:
            month=@"Agosto";
            break;
        case 9:
            month=@"Septiembre";
            break;
        case 10:
            month=@"Octubre";
            break;
        case 11:
            month=@"Noviembre";
            break;
        case 12:
            month=@"Diciembre";
            break;
            
        default:
            break;
    }
    
    //Asignamos el 3er par de numeros al string año
    NSString *year = [_selectedHour substringWithRange:NSMakeRange(4, 2)];
    
    //Asignamos el 4rto par de numeros al string hora
    NSString *hour = [_selectedHour substringWithRange:NSMakeRange(6, 2)];
    
    //Guardamos en la variable compelete Hour la fecha en formato texto largo para ponerlo en la titleLabel y guardarlo en la tabla mediante el webservice.
    completeHour = [NSString stringWithFormat:@"%@ de %@ del 20%@ a las %@:00", day, month, year, hour];
    
    //Le asignamos el texto completo a la titleLabel
    self.titleLabel.text = [NSString stringWithString:completeHour];
    
    //Ejecutamos el metodo booking
    [self booking];
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Metodo que escondera el teclado en el caso que cliquemos en la tecla DONE o RETURN del teclado cuando estemos escribiendo en las cajas de texto
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;

}

//Metodo que se lanza automaticamente cuando la vista va a desaparecer. Con esto controlamos que al pulsar en el boton Back del navigation controller eliminamos la reserva hecha previamente.
-(void) viewWillDisappear:(BOOL)animated {
    
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
    
        //Sabemos que se ha pulsado back porque el view controller ha sido eliminado
        //de la pila de view controllers
        
        //Si desaparece de la pila, ejecutamos el metodo deleteBooking
        [self deleteBooking];
        
    }
    
    //Si no ha desaparecido, seguimos sin ejecutar nada
    [super viewWillDisappear:animated];
}

//Metodo encargado de, una vez dentro de esta pantalla, enviar al webservice la informacion necesaria para "reservar" esta cita para que no la pueda seleccionar otro usuario mientras rellenamos el formulario
-(void)booking{
    
    NSString *webserviceUrl = [[NSString stringWithFormat:@"%@?method=setReservaHora&code=%@&hora=%@", BaseURLString, _selectedHour, completeHour]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSLog(@"%@ guardada correctamente", _selectedHour);
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        
                                                    }];
    
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operation start];
    
}

//Metodo que se conecta al Webservice para eliminar la fecha y hora seleccionada de la base de datos donde hemos guardado
-(void)deleteBooking{
    
    NSString *webserviceUrl = [[NSString stringWithFormat:@"%@?method=setEliminarReserva&code=%@", BaseURLString, _selectedHour]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        if ([JSON isEqual:[NSNull null]]) {
                                                            NSLog(@"El JSON llega vacio");
                                                        }else{
                                                                                                                    
                                                        NSLog(@"%@", [JSON class]);
                                                        NSLog(@"%@ eliminado correctamente", _selectedHour);
                                                        NSLog(@"Lo que se ha eliminado es %@", JSON);
                                                    }
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"Hay algun error");
                                                        NSLog(@"%@", error);
                                                    }];
    
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operation start];

}

//Metodo que controla la transiccion entre esta vista y la siguiente
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showBookingInfo"]){
        
        //Guardamos lo introducido en el primer text box dentro de la variable insertedName
        insertedName = _name.text;
        
        //Guardamos lo introducido en el segundo text box dentro de la variable insertedPhone
        insertedPhone = _phone.text;
        
        //Guardamos lo introducido en el tercer text box dentro de la variable insertedcomments
        insertedComments = _comments.text;
        
        //Creamos el objeto de la clase que controla la vista de destino
        NotificationConfirmationViewController *destViewController = segue.destinationViewController;
        
        //Le indicamos que seguimos sin querer ver los botones de la barra inferior
        destViewController.hidesBottomBarWhenPushed = YES;
        
        //Enviamos los datos insertados en las text box a las variables indicadas de la siguiente vista
        destViewController.strName = [NSString stringWithString:insertedName];
        destViewController.strPhone = [NSString stringWithString:insertedPhone];
        destViewController.strComents = [NSString stringWithString:insertedComments];
        destViewController.strTitle = [NSString stringWithString:completeHour];
        
        //Ejecutamos el metodo que guarda la informacion completa en la base de datos
        [self bookingCompleteInfo];
        
        
    }
}

//Metodo que guarda toda la informacion de la reserva en la base de datos.
-(void)bookingCompleteInfo{
    
    NSString *webserviceUrl = [[NSString stringWithFormat:@"%@?method=setConfirmacionReserva&code=%@&nombre=%@&telefono=%@&comentarios=%@", BaseURLString, _selectedHour, [NSString stringWithString:insertedName], [NSString stringWithString:insertedPhone], [NSString stringWithString:insertedComments]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSLog(@"La reserva a sido confirmada correctamente");
                                                        NSLog(@"%@", [JSON class]);
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                       
                                                    }];
    
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operation start];
    
}
@end
