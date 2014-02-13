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
    [self.theSwitch removeTarget:nil
                          action:NULL
                forControlEvents:UIControlEventValueChanged];
}
@end

@interface MBDebugPanelSimpleSwitchComponent()
@property (nonatomic, copy, readwrite)       NSString *title;
@property (nonatomic, copy, readwrite) void(^onSwitchChanged)(BOOL newValue);
@end

@implementation MBDebugPanelSimpleSwitchComponent

-(id)initWithTitle:(NSString*)title onSwitchChanged:(void(^)(BOOL))changeHandler
{
    if (self = [super init]) {
        [self setOnSwitchChanged:changeHandler];
        [self setTitle:title];
    }
    return self;
}

-(void)switchValueChanged:(id)sender
{
    UISwitch *theSwitch = (id)sender;
    if (self.onSwitchChanged)
        self.onSwitchChanged(theSwitch.isOn);
}

#pragma mark protected/overridden methods
-(NSString*)cellClassName
{
    return NSStringFromClass([MBDebugPanelSimpleSwitchComponentCell class]);
}


-(void)bindToReusableCell:(MBDebugPanelSimpleSwitchComponentCell*)cell
{
    [cell.label setText:self.title];
    [cell.theSwitch addTarget:self
                       action:@selector(switchValueChanged:)
             forControlEvents:UIControlEventValueChanged];
}

@end
