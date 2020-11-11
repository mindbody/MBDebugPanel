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
//  MBDebugPanelSimpleButtonComponent.m
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import "MBDebugPanel.h"
#import "MBDebugPanelSimpleComponent_Protected.h"
#import "MBDebugPanelSimpleButtonComponent.h"

@interface MBDebugPanelSimpleButtonComponentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation MBDebugPanelSimpleButtonComponentCell
-(void)prepareForReuse
{
    [super prepareForReuse];
    [self.button removeTarget:nil
                       action:NULL
             forControlEvents:UIControlEventTouchUpInside];
}
@end



@interface MBDebugPanelSimpleButtonComponent()
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *buttonTitle;
@property (nonatomic, copy, readwrite) void(^onButtonPressed)(void);
@end

@implementation MBDebugPanelSimpleButtonComponent
-(id)initWithTitle:(NSString*)title buttonTitle:(NSString*)buttonTitle onButtonPressed:(void (^)(void))onButtonPressed
{
    if (self = [super init]) {
        [self setTitle:title];
        [self setButtonTitle:buttonTitle];
        [self setOnButtonPressed:onButtonPressed];
    }
    return self;
}

-(void)buttonTapped:(id)sender
{
    if (self.onButtonPressed)
        self.onButtonPressed();
}

#pragma mark protected, overridden methods
-(NSString*)cellClassName
{
    return  NSStringFromClass([MBDebugPanelSimpleButtonComponentCell class]);
}

-(void)bindToReusableCell:(MBDebugPanelSimpleButtonComponentCell *)cell
{
    [cell.label setText:self.title];
    [cell.button setTitle:self.buttonTitle forState:UIControlStateNormal];
    [cell.button addTarget:self
                    action:@selector(buttonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
}

@end
