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
