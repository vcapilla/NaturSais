//
//  notificationConfirmationViewController.m
//  NaturSais
//
//  Created by Victor Capilla on 24/10/13.
//  Copyright (c) 2013 ParcApp. All rights reserved.
//
//Clase que se encarga de controlar la vista donde mostramos la informacion introducida por el usuario

#import "NotificationConfirmationViewController.h"

@interface NotificationConfirmationViewController ()

@end

@implementation NotificationConfirmationViewController

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

    //Rellenamos las etiquetas con la informacion obtenida de la vista anterior
    _lblName.text = [NSString stringWithString:_strName];
    _lblPhone.text = [NSString stringWithString:_strPhone];
    _lblComents.text = [NSString stringWithString:_strComents];
    _lblTitle.text = [NSString stringWithString:_strTitle];
    
    //No queremos que puedan volver hacia atras porque ya se ha confirmado
    self.navigationItem.hidesBackButton = YES;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Al clicar en el boton de OK volvera a la primera vista
-(IBAction)endProcess:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
