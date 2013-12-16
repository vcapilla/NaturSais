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
@implementation ContactView

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
	// Do any additional setup after loading the view.
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    _versonLabel.text = [NSString stringWithFormat:@"Version: %@",version];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(28/255.0) green:(145/255.0) blue:(41/255.0) alpha:(200/255.0)]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Metodo que abrira la web del cliente. Podemos obserbar que controlamos que exista una aplicacion instalada en el dispositivo para poder realizar la accion.
-(IBAction)linkButtonClick:(id)sender {
    //URL de la web a mostrar
    NSString* launchUrl = @"http://www.natursais.com";
    //Condicion para controlar que existe una app instalada para poder ver la web. En el caso de que no se pueda, se mostrar un error flotante.
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder abrir esta web." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
        //Ejecucion del programa que pueda abrir dicho link en nuestro dispositivo
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]];
        
    }
    
}


//Metodo que llamara al cliente. Podemos obserbar que controlamos que exista una aplicacion instalada en el dispositivo para poder realizar la accion.

-(IBAction)phoneNumberClick:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Llamando" message:@"Desea realizar la llama?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil];
    [alert show];

}
    
    - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (buttonIndex == 0)
        {
            NSLog(@"No llamar");
        }
        if (buttonIndex == 1)
        {
            NSLog(@"Si llamar");
            //Telefono al que llamara al pulsar encima del link
            NSString *phoneNumber = @"tel://608140283";
            //Condicion para controlar si existe una app para poder realizar llamadas
            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: phoneNumber]]) {
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder realizar una llamada." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [av show];
                
            }else{
                
                //Realizamos la llamada
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
            }

        }
    }
    
    



//Metodo que abrira un mensaje de correo nuevo con la direccion que queramos.
-(IBAction)mailClick:(id)sender{
    
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
-(IBAction)mapClick:(id)sender{
    
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(41.150101, 1.097914);
    
    
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = @"NaturSais";
        [item openInMapsWithLaunchOptions:nil];
     

}
-(IBAction)parcappClick:(id)sender{
    
    
    //URL de la web a mostrar
    NSString* launchUrl = @"http://www.parcapp.es";
    //Condicion para controlar que existe una app instalada para poder ver la web. En el caso de que no se pueda, se mostrar un error flotante.
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para poder abrir esta web." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
        //Ejecucion del programa que pueda abrir dicho link en nuestro dispositivo
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithString:launchUrl]]];
        
    }


}
@end
