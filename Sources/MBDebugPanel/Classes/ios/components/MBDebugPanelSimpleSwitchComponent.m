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
//  MBDebugPanelSimpleSwitchComponent.m
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import "MBDebugPanel.h"
#import "MBDebugPanelSimpleComponent_Protected.h"
#import "MBDebugPanelSimpleSwitchComponent.h"

@interface MBDebugPanelSimpleSwitchComponentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel  *label;
@property (weak, nonatomic) IBOutlet UISwitch *theSwitch;
@end

@implementation MBDebugPanelSimpleSwitchComponentCell
-(void)prepareForReuse
{
    [super prepareForReuse];
    [self.theSwitch removeTarget:nil
                          action:NULL
                forControlEvents:UIControlEventValueChanged];
}
@end

@interface MBDebugPanelSimpleSwitchComponent()
@property (nonatomic, copy, readwrite)       NSString *title;
@property (nonatomic, copy, readwrite) void(^onSwitchChanged)(BOOL newValue);

// We can't determine this value from the state of a UISwitch when rendered,
// table cells are re-used
@property (nonatomic) BOOL isSwitchOn;
@end

@implementation MBDebugPanelSimpleSwitchComponent

-(id)initWithTitle:(NSString *)title
      initialValue:(BOOL)isOn
   onSwitchChanged:(void(^)(BOOL newValue))changeHandler
{
    if (self = [super init]) {
        [self setOnSwitchChanged:changeHandler];
        [self setIsSwitchOn:isOn];
        [self setTitle:title];
    }
    return self;
}

-(void)switchValueChanged:(id)sender
{
    UISwitch *theSwitch = (id)sender;
    if (self.onSwitchChanged) {
        self.isSwitchOn = theSwitch.isOn;
        self.onSwitchChanged(theSwitch.isOn);
    }
}

#pragma mark protected/overridden methods
-(NSString*)cellClassName
{
    return NSStringFromClass([MBDebugPanelSimpleSwitchComponentCell class]);
}


-(void)bindToReusableCell:(MBDebugPanelSimpleSwitchComponentCell*)cell
{
    [cell.label setText:self.title];
    [cell.theSwitch setOn:self.isSwitchOn];
    [cell.theSwitch addTarget:self
                       action:@selector(switchValueChanged:)
             forControlEvents:UIControlEventValueChanged];
}

@end
