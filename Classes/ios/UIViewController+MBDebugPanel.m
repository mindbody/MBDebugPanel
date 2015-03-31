//
//  UIViewController+MBDebugPanel.m
//  MBDebugPanel
//
//  Created by Ian on 3/27/15.
//
//

#import "UIViewController+MBDebugPanel.h"

#import "MBDebugPanel.h"

#import <JGMethodSwizzler/JGMethodSwizzler.h>

#import <objc/runtime.h>

NSString *const MB_UIViewController_Utility_debugMenuItemsManagementEnabledKey = @"MB_UIViewController_Utility_debugMenuItemsManagementEnabled";
NSString *const MB_UIViewController_Utility_managedDebugMenuItemsKey = @"MB_UIViewController_Utility_managedDebugMenuItemsKey";

@interface UIViewController (MBDebugPanel_Private)

@property (retain, readwrite) NSMutableArray *mb_managedDebugMenuItems;

@end

@implementation UIViewController (MBDebugPanel)

- (void)setMb_debugMenuItemsManagementEnabled:(BOOL)mb_debugMenuItemsManagementEnabled
{
    // TODO: what if we call this from viewWillAppear or viewDidDisappear??

    if (mb_debugMenuItemsManagementEnabled == true && self.mb_debugMenuItemsManagementEnabled == false)
    {
        [self swizzleMethod:@selector(viewWillAppear:) withReplacement:JGMethodReplacementProviderBlock {
            return JGMethodReplacement(void, UIViewController *, BOOL animated) {
                JGOriginalImplementation(BOOL, animated);
                
                [MBDebugPanel addComponentsFromArray:self.mb_managedDebugMenuItems];
            };
        }];
        
        [self swizzleMethod:@selector(viewDidDisappear:) withReplacement:JGMethodReplacementProviderBlock {
            return JGMethodReplacement(void, UIViewController *, BOOL animated) {
                JGOriginalImplementation(BOOL, animated);
                
                if ( [MBDebugPanel isPresented] ) {
                    [MBDebugPanel hide];
                }
                
                [MBDebugPanel removeComponentsInArray:self.mb_managedDebugMenuItems];
            };
        }];
    } else if (mb_debugMenuItemsManagementEnabled == false && self.mb_debugMenuItemsManagementEnabled == true)
    {
        [self deswizzleMethod:@selector(viewWillAppear:) ];
        [self deswizzleMethod:@selector(viewDidDisappear:) ];
    }
    objc_setAssociatedObject(self, CFBridgingRetain(MB_UIViewController_Utility_debugMenuItemsManagementEnabledKey), [NSNumber numberWithBool:mb_debugMenuItemsManagementEnabled], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)mb_debugMenuItemsManagementEnabled
{
    BOOL result = NO;
    
    id boolObject = objc_getAssociatedObject(self, CFBridgingRetain(MB_UIViewController_Utility_debugMenuItemsManagementEnabledKey) );
    if ( [boolObject isKindOfClass:[NSNumber class] ] )
    {
        NSNumber *boolNumber = boolObject;
        result = [boolNumber boolValue];
    }
    
    return result;
}

- (void)mb_addManagedDebugMenuItems:(NSArray *)items
{
    if (self.mb_managedDebugMenuItems == nil)
    {
        self.mb_managedDebugMenuItems = [NSMutableArray arrayWithArray:items];
    } else
    {
        [self.mb_managedDebugMenuItems addObjectsFromArray:items];
    }
}

- (void)mb_removeManagedDebugMenuItems:(NSArray *)items
{
    [self.mb_managedDebugMenuItems removeObjectsInArray:items];
}

- (void)setMb_managedDebugMenuItems:(NSMutableArray *)managedDebugMenuItems
{
    objc_setAssociatedObject(self, CFBridgingRetain(MB_UIViewController_Utility_managedDebugMenuItemsKey), managedDebugMenuItems, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)mb_managedDebugMenuItems
{
    NSMutableArray *result;
    
    id itemsObject = objc_getAssociatedObject(self, CFBridgingRetain(MB_UIViewController_Utility_managedDebugMenuItemsKey) );
    if ( [itemsObject isKindOfClass:[NSMutableArray class] ] )
    {
        result = itemsObject;
    }
    
    return result;
}

- (void)mb_addDebugMenuGestureRecognizer:(UIGestureRecognizer *)recognizer
{
    [self mb_addDebugMenuGestureRecognizer:recognizer onView:self.view];
}

- (void)mb_addDebugMenuGestureRecognizer:(UIGestureRecognizer *)recognizer onView:(UIView *)view
{
    [recognizer addTarget:self action:@selector(mb_openDebugPanelFromGesture:) ];
    [view addGestureRecognizer:recognizer];
}

- (void)mb_addDebugMenuTapGestureRecognizer:(NSUInteger)numberOfTaps
{
    [self mb_addDebugMenuTapGestureRecognizer:numberOfTaps onView:self.view];
}

- (void)mb_addDebugMenuTapGestureRecognizer:(NSUInteger)numberOfTaps onView:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [ [UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(mb_openDebugPanelFromGesture:) ];
    tapGesture.numberOfTapsRequired = numberOfTaps;
    [view addGestureRecognizer:tapGesture];
}

- (void)mb_openDebugPanel
{
    [MBDebugPanel show];
}

- (void)mb_openDebugPanelFromGesture:(UITapGestureRecognizer *)tapGesture
{
    [MBDebugPanel show];
}

@end
