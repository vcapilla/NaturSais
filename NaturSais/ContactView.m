//
//  ContactView.m
//  NaturSais
//
//  Created by Victor Capilla on 09/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//

#import "ContactView.h"

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


//Metodo que abrira un mensaje de correo nuevo con la direccion que queramos.
-(IBAction)mailClick:(id)sender{
    
    //Direccion de correo del cliente
    NSString *mail = @"mailto://parcapp@parcapp.es";
    
    //Condicion que controla que hay una app de mail en el telefono
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: mail]]) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Complemento no disponible" message:@"No dispone de ninguna aplicacion para gestionar el correo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
        
        //Lanzamos la aplicacion para escribir el mail desde la app del mobil.
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mail]];
    }
}
@end
