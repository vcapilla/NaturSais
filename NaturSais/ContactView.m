//
//  ContactView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "ContactView.h"
#import <MapKit/MapKit.h>

@interface ContactView ()

@end

//Esto es la pantalla de contacto
@implementation ContactView{
    NSDictionary *contactContent;
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
    
    UIImage *logo = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView =[[UIImageView alloc] initWithImage:logo];
        
    _tableView.backgroundColor = [UIColor clearColor];
    
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
    
    contactContent = @{@"Web" : @"www.natursais.com", @"Mail" : @"natursais@gmail.com", @"Direccion" : @"C\\ del Pont, 1 Baixos, Reus", @"Telefono" : @"608140283"};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contactContent count];
}

//Metodo que controla el contenido de cada celda de nuestra tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    static NSString *simpleTableIdentifier = @"ContactCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
    }
    
    
    NSString *key = [contactContent allKeys][indexPath.row];
    NSString *detail = [contactContent objectForKey:key];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(62/255.0) green:(154/255.0) blue:(51/255.0) alpha:(50/255.0)]];
    
    cell.selectedBackgroundView = bgColorView;
    cell.textLabel.text = [NSString stringWithString:key];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", detail];
    
    
    
    //Retornamos la celda
    return cell;
    
}




//Metodo que abrira la web del cliente. Podemos obserbar que controlamos que exista una aplicacion instalada en el dispositivo para poder realizar la accion.
-(void)linkButtonClick{
    //URL de la web a mostrar
    NSString* launchUrl = @"http://www.natursais.com";
    //Condicion para controlar que existe una app instalada para poder ver la web. En el caso de que no se pueda, se mostrar un error flotante.
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder abrir esta web." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
        [av show];
        
    }else{
        //Ejecucion del programa que pueda abrir dicho link en nuestro dispositivo
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]];
        
    }
    
}


//Metodo que llamara al cliente. Podemos obserbar que controlamos que exista una aplicacion instalada en el dispositivo para poder realizar la accion.

-(void)phoneNumberClick{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Llamando" message:@"Desea llamar al 608140283?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
    [alert show];

}
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (buttonIndex == 0)
        {
            NSLog(@"No llamar");
            [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
        
        }
        if (buttonIndex == 1)
        {
            NSLog(@"Si llamar");
            //Telefono al que llamara al pulsar encima del link
            NSString *phoneNumber = @"tel://608140283";
            //Condicion para controlar si existe una app para poder realizar llamadas
            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: phoneNumber]]) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder realizar una llamada." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
                [av show];
               
                
            }else{
                
                //Realizamos la llamada
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
            }

        }
    }


//Metodo que abrira un mensaje de correo nuevo con la direccion que queramos.
-(void)mailClick{
    
    //Direccion de correo del cliente
    NSString *mail = @"mailto://natursaistienda@gmail.com";
    
    //Condicion que controla que hay una app de mail en el telefono
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: mail]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para gestionar el correo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
        
        //Lanzamos la aplicacion para escribir el mail desde la app del mobil.
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mail]];
    }
}
-(void)mapClick{
    
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(41.150101, 1.097914);
    
    
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = @"NaturSais";
        [item openInMapsWithLaunchOptions:nil];
     

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *title = cell.textLabel.text;
    
    if ([title isEqualToString:@"Web"]) {
        [self linkButtonClick];
    }else if([title isEqualToString:@"Telefono"]){
        [self phoneNumberClick];
    }else if([title isEqualToString:@"Mail"]){
        [self mailClick];
    }else if([title isEqualToString:@"Direccion"]){
        [self mapClick];
    }
    
    

}

@end
