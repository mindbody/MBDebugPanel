//Copyright (c) 2014 MINDBODY, Inc. <www.mindbodyonline.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
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
    
    self.mb_debugPanelItemsManagementEnabled = YES;
    [self mb_addManagedDebugPanelItems:self.debugPanelComponents];
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
                                                  initialValue:NO
                                               onSwitchChanged:(^(BOOL newValue) {
        NSLog(@"Switch changed. New value => %d", newValue);
    })];

    MBDebugPanelSimpleButtonComponent *buttonComponent
    = [[MBDebugPanelSimpleButtonComponent alloc] initWithTitle:@"Run some code!"
                                                   buttonTitle:@"Run"
                                               onButtonPressed:(^{
        NSLog(@"Button tapped!");
    })];
    
    MBDebugPanelSimpleTextFieldComponent *textFieldComponent
    = [[MBDebugPanelSimpleTextFieldComponent alloc] initWithTitle:@"Change yer value!"
                                                  placeholderText:@"Value goes here!"
                                                      initialText:^NSString *{
                                                          return @"Change me!";
                                                      } onEditingDidEnd:^(NSString *text) {
                                                          NSLog(@"Text Field changed. New value => %@", text);
                                                      }];
    
    return _debugPanelComponents = @[switchComponent, buttonComponent, textFieldComponent];
}

- (IBAction)showPanelTapped:(id)sender {
    [MBDebugPanel show];
}

@end
