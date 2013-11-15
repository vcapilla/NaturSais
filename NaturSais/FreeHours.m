//
//  FreeHours.m
//  NaturSais
//
//  Created by Victor Capilla on 10/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.

//Clase encargada de la pantalla que muestra las horas disponibles y en la cual marcaremos la hora que queramos

#import "FreeHours.h"
#import "BookingFormViewController.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"

//URL sin envio de mail
//static NSString *const BaseURLString = @"http://natursais.tk/testservice.php";

//URL con envia de mail
static NSString *const BaseURLString = @"http://natursais.tk/natursais_test_service_con_mail/testservice.php";

@interface FreeHours ()

@end

@implementation FreeHours{

    //Variables de la implementacion
    NSMutableArray *codesToUse;
    NSMutableArray *freeHoursList;
    NSMutableArray *codesObtained;
    MBProgressHUD *hud ;
    
}

- (void)viewDidLoad
{
        //Inicializacion de Array donde guardamos las horas posibles a reservar
    freeHoursList = [NSMutableArray arrayWithObjects:
                     [NSString stringWithFormat:@"%@10",_code],
                     [NSString stringWithFormat:@"%@11",_code],
                     [NSString stringWithFormat:@"%@12",_code],
                     [NSString stringWithFormat:@"%@13",_code],
                     [NSString stringWithFormat:@"%@16",_code],
                     [NSString stringWithFormat:@"%@17",_code],
                     [NSString stringWithFormat:@"%@18",_code],
                     [NSString stringWithFormat:@"%@19",_code],nil];
    self.navigationItem.title = @"Escoge una hora";
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    [super viewDidLoad];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Metodo que, usando la variable code nos devuelve las horas ocupadas para ese dia obteniendolas de un webservice
-(void)loadData{
    
  
    
    //Guardamos la URL del webservice con los parametros necesarios en un string
    NSString *webserviceUrl = [NSString stringWithFormat:@"%@?method=getBooking&code=%@", BaseURLString, _code];
    //Le damos el formato URL al string anterior
    NSURL *url = [NSURL URLWithString:webserviceUrl];
    //Metelos el url en un paquete de consulta.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //Objeto del tipo AFJSONRequestOperation (del framework AFNetworking) que se encarga de obtener un objeto JSON de un webservice
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     
        //Si no hay ningun error y obtenemos el paquete JSON lo analizamos dentrod e success
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
        //Si el paquete viene vacio , quiere decir que todas las horas estan disponibles porque no hay ninguna ocpupada
        if ([JSON isEqual:[NSNull null]]) {
            
           //copiamos el contenido del array freeHoursList a codesToUse que seran los codes que usaremos para mostrar las horas disponibles
           codesToUse = [freeHoursList mutableCopy];
                                                        
        //Si el JSON no esta vacio
        }else{
        
            //Convertimios en un array el fichero JSON pasandolo por el metodo arrayFromJson que nos facilita el trabajo de parsear
            NSArray *jsonGuardado = [self arrayFromJson:JSON];
            
            //Comprobamos que el contenido del JSON no sea mayor a 7 ya que si es mayor que 7 quiere decir que todas las horas para ese dia estan ocupadas
            if (jsonGuardado.count > 7) {
            
                //Si estan cupadas mostramos un AlertView que llamaremos desde el metodo error de esta misma clase
                [self error:@"No hay horas disponibles" message:@"El dia seleccionado esta completo"];
                
            //Si el contenido del JSON no es mayor de 7, continuamos
            }else{
            
                //Guardamos en un array solo los datos que correspondan a la Key code.
                codesObtained = [NSMutableArray arrayWithArray:[jsonGuardado valueForKey:@"code"]];
                                                            
                //Hacemos una copia de las horas posibles al array de Codigos a usar
                codesToUse = [freeHoursList mutableCopy];
                
                //Eliminamos de los codigos que hemos copiado del array c
                [codesToUse removeObjectsInArray:codesObtained];
                
            }
            
        }
        
            //Rellenamos la tableView
            [self.tableView reloadData];
            [hud hide:YES];
            
        }
        //Esto se lanzara si hay algun error
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        
            //AlertView que muestra el error
            [self error:@"Error en la conexión" message:[NSString stringWithFormat:@"Problemas en la comunicación"]];
            
            //Log que nos ayuda a saber donde esta el problema
            NSLog(@"Algo esta pasando en el metodo loadData");

        }];
    
    //Esto nos permite operar con obejetos de bajo nibel sin necesidad de que sea un Array o un Diccionario
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    
    //Lanzamos la operacion
    [operation start];
    
    
}


//Metodo encargado de indicar cuantas filas debe tener nuestra tabla
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [codesToUse count];
}

//Metodo que controla el contenido de cada celda de nuestra tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"HourCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    //Guardamos el contenido del array codeToUse en la posicion del indice de la celda que vamos a rellenar
    NSString *obtainedCode = [codesToUse objectAtIndex:indexPath.row];
    
    //Substraemos unicamente los 2 ultimos numeros que son la hora
    NSString *hour = [obtainedCode substringWithRange:NSMakeRange(6, 2)];
    
    //Le añadimos los :00
    cell.textLabel.text = [NSString stringWithFormat:@"%@:00", hour];
    
    //Lo alineamos en el centro
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //Retornamos la celda
    return cell;
    
}

//Transicion que se encarga de enviar informacion a la siguiente vista
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //comprobamos que nuestra transicion corresponde con el nombre que le hemos dado
    if([segue.identifier isEqualToString:@"fillForm"]){
        
        //Capturamos el index de la celda pulsada
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        //Creamos el objeto de la vista destino
        BookingFormViewController *destViewController = segue.destinationViewController;
        
        //Indicamos que en la vista destino deshabilite la barra de botones inferior
        destViewController.hidesBottomBarWhenPushed = YES;
        
        //Le asignamos a la variable selectedHour el codigo que hemos usado en esta vista para poder usarlo
        destViewController.selectedHour = [codesToUse objectAtIndex:indexPath.row];
        
    }
}

//Metodo obtenido gracias al JSONKit
-(NSArray *)arrayFromJson:(NSString *) JSONString {
    
    //Descodificamos el JSON para poder guardarlo en un Array
    JSONDecoder * decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    
    return [decoder mutableObjectWithData:[JSONString JSONData]];
    
}

//Metodo que se lanza cuando va a aparecer esta vista
-(void)viewWillAppear:(BOOL)animated{
    
    //le decimos que ejecute el metodo loadData cada vez que se abre esta vista
    [self loadData];
    
    
}

//Metodo en el que configuramos un AlertView para las alertas de esta clase
-(void)error:(NSString *)title message:(NSString* )message{
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",title]
    
                                                message:[NSString stringWithFormat:@"%@",message]
                       
                                                delegate:nil
                       
                                                cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
}

@end