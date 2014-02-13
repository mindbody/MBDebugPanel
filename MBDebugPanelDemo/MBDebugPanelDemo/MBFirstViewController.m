//
//  MBFirstViewController.m
//  MBDebugPanelDemo
//
//  Created by Matthew Holden on 2/6/14.
//  Copyright (c) 2014 MINDBODY. All rights reserved.
//

#import "MBFirstViewController.h"
#import <MBDebugPanel/MBDebugPanel.h>

@interface MBFirstViewController ()
@property (nonatomic) NSArray *debugPanelComponents;
@end

@implementation MBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)configureAndShowDebugPanel
{

    // Add the panel above the main window
    [MBDebugPanel show];
}

-(NSArray*)debugPanelComponents
{
    if (_debugPanelComponents)
        return _debugPanelComponents;


    MBDebugPanelSimpleSwitchComponent *switchComponent
    = [[MBDebugPanelSimpleSwitchComponent alloc] initWithTitle:[NSString stringWithFormat:@"Feature switch for %@", NSStringFromClass(self.class)]
                                               onSwitchChanged:(^(BOOL newValue) {
        NSLog(@"Switch changed. New value => %d", newValue);
    })];

    MBDebugPanelSimpleButtonComponent *buttonComponent
    = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Run some code!"
                                                   buttonTitle:@"Run"
                                               onButtonPressed:(^{
        NSLog(@"Button tapped!");
    })];

    return _debugPanelComponents = @[switchComponent, buttonComponent];
}

-(void)viewDidAppear:(BOOL)animated
{
    [MBDebugPanel addComponentsFromArray:self.debugPanelComponents];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([MBDebugPanel isPresented]) {
        [MBDebugPanel hide];
    }
    [MBDebugPanel removeComponentsInArray:self.debugPanelComponents];
}

- (IBAction)showPanelTapped:(id)sender {
    [MBDebugPanel show];
}

@end
