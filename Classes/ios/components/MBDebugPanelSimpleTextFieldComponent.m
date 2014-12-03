//
//  MBDebugPanelSimpleTextFieldComponent.m
//  MBDebugPanel
//
//  Created by Ian on 12/3/14.
//
//

#import "MBDebugPanel.h"
#import "MBDebugPanelSimpleComponent_Protected.h"
#import "MBDebugPanelSimpleTextFieldComponent.h"

@interface MBDebugPanelSimpleTextFieldComponentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation MBDebugPanelSimpleTextFieldComponentCell
-(void)prepareForReuse
{
    self.textField.delegate = nil;
}
@end

@interface MBDebugPanelSimpleTextFieldComponent()
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *placeholderText;
@property (nonatomic, copy, readwrite) NSString *(^initialText)();
@property (nonatomic, copy, readwrite) void(^onEditingDidEnd)(NSString *text);
@end

@implementation MBDebugPanelSimpleTextFieldComponent
-(id)initWithTitle:(NSString *)title placeholderText:(NSString *)placeholderText initialText:(NSString *(^)(void))initialText onEditingDidEnd:(void (^)(NSString *))onEditingDidEnd
{
    if (self = [super init]) {
        self.title = title;
        self.placeholderText = placeholderText;
        self.initialText = initialText;
        self.onEditingDidEnd = onEditingDidEnd;
    }
    return self;
}

#pragma mark protected, overridden members
-(NSString *)cellClassName
{
    return NSStringFromClass([MBDebugPanelSimpleTextFieldComponentCell class]);
}

-(void)bindToReusableCell:(MBDebugPanelSimpleTextFieldComponentCell *)cell
{
    cell.label.text = self.title;
    cell.textField.placeholder = self.placeholderText;
    if (self.initialText)
    {
        cell.textField.text = self.initialText();
    }
    cell.textField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.onEditingDidEnd)
    {
        self.onEditingDidEnd(textField.text);
    }
}
@end
