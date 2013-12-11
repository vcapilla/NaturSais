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
#import "JSONKit.h"

//URL sin envio de mail
//static NSString *const BaseURLString = @"http://natursais.tk/testservice.php";

//URL con envio de mail
static NSString *const BaseURLString = @"http://natursais.esy.es/service/diary_service_natursais.php";


@interface BookingFormViewController ()

@end

@implementation BookingFormViewController{
    
    //Variables de la implementacion
    NSString *completeHour;
    NSString *insertedName;
    NSString *insertedPhone;
    NSString *insertedComments;
    NSString *localizador;
    NSMutableArray *localizadorMA;

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

//Metodo que se ejecutara al pulsar al boton de confirmacion
-(IBAction)checkTextFields{
    
    //Comprobamos que se ha introducido algo en el campo Nombre
    if (_name.text.length == 0) {
        
        //Si no se ha introducido nada, mostramos un error por pantalla
        [self error:@"Informacion incompleta" message:@"Introduzca un Nombre"];
        
        
    //Si se ha escrito algo en el campo Nombre, comprobamos que se haya escrito algo en el campo Telefono
    }else if(_phone.text.length == 0){
        
        //Si no se ha introducido nada, mostramos un error por pantalla
        [self error:@"Informacion incompleta" message:@"Introduzca un Numero de Telefono"];
               
    //Si se ha comrpobado todo y todo esta OK, lanzamos la transicion entre las 2 vistas.
    }else{
    
        //Guardamos lo introducido en el primer text box dentro de la variable insertedName
        insertedName = _name.text;
        
        //Guardamos lo introducido en el segundo text box dentro de la variable insertedPhone
        insertedPhone = _phone.text;
    if(_comments.text.length == 0){
        
        
        insertedComments = @"NO COMMENTS";
    }else{        //Guardamos lo introducido en el tercer text box dentro de la variable insertedcomments
    insertedComments = _comments.text;
    }
        //Ejecutamos el metodo que guarda la informacion completa en la base de datos
        [self bookingCompleteInfo];        
        
    }

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
                                                        NSLog(@"%@", error);
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
        
        
        //Creamos el objeto de la clase que controla la vista de destino
        NotificationConfirmationViewController *destViewController = segue.destinationViewController;
        
        //Le indicamos que seguimos sin querer ver los botones de la barra inferior
        destViewController.hidesBottomBarWhenPushed = YES;
        
        //Enviamos los datos insertados en las text box a las variables indicadas de la siguiente vista
        destViewController.strName = [NSString stringWithString:insertedName];
        destViewController.strPhone = [NSString stringWithString:insertedPhone];
        destViewController.strComents = [NSString stringWithString:insertedComments];
        destViewController.strTitle = [NSString stringWithString:completeHour];
        destViewController.strDate = _selectedHour;
        destViewController.strLocalizador = localizador;
       
        
    }
}

//Metodo que guarda toda la informacion de la reserva en la base de datos.
-(void)bookingCompleteInfo{
    
    NSString *webserviceUrl = [[NSString stringWithFormat:@"%@?method=setConfirmacionReserva&code=%@&nombre=%@&telefono=%@&comentarios=%@", BaseURLString, _selectedHour, [NSString stringWithString:insertedName], [NSString stringWithString:insertedPhone], [NSString stringWithString:insertedComments]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSArray *jsonGuardado = [self arrayFromJson:JSON];
                                                        localizadorMA = [NSMutableArray arrayWithArray:[jsonGuardado valueForKey:@"LOCALIZADOR"]];
                                                        localizador = localizadorMA[0];
                                                        NSLog(@"%@ del tipo %@", localizador, [localizador class]);
                                                        
                                                        //Indicamos el identificador de segue que queremos lanzar y desde donde lo lanzamos
                                                        [self performSegueWithIdentifier:@"showBookingInfo" sender:self];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"Algo a fallado en bookingCompleteInfo");
                                                        NSLog(@"%@", error);
                                                    }];
    
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    [operation start];
    
}

//Metodo en el que configuramos un AlertView para las alertas de esta clase
-(void)error:(NSString *)title message:(NSString* )message{
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",title]
                       
                                                 message:[NSString stringWithFormat:@"%@",message]
                       
                                                delegate:nil
                       
                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
}

//Metodo obtenido gracias al JSONKit
-(NSArray *)arrayFromJson:(NSString *) JSONString {
    
    //Descodificamos el JSON para poder guardarlo en un Array
    JSONDecoder * decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    
    return [decoder mutableObjectWithData:[JSONString JSONData]];
    
}

@end
