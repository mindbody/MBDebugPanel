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

const char* MB_UIViewController_Utility_debugPanelItemsManagementEnabledKey = "MB_UIViewController_Utility_debugPanelItemsManagementEnabled";
const char* MB_UIViewController_Utility_managedDebugPanelItemsKey = "MB_UIViewController_Utility_managedDebugPanelItemsKey";

@interface UIViewController (MBDebugPanel_Private)

@property (retain, readwrite) NSMutableArray *mb_managedDebugPanelItems;

@end

@implementation UIViewController (MBDebugPanel)

- (void)setMb_debugPanelItemsManagementEnabled:(BOOL)mb_debugPanelItemsManagementEnabled
{
    // TODO: test what happens if we call this from viewWillAppear or viewDidDisappear
    if (mb_debugPanelItemsManagementEnabled == self.mb_debugPanelItemsManagementEnabled) {
        return;
    }

    if (mb_debugPanelItemsManagementEnabled == true) {
        [self swizzleMethod:@selector(viewWillAppear:) withReplacement:JGMethodReplacementProviderBlock {
            return JGMethodReplacement(void, UIViewController *, BOOL animated) {
                JGOriginalImplementation(BOOL, animated);
                
                [MBDebugPanel addComponentsFromArray:self.mb_managedDebugPanelItems];
            };
        }];
        
        [self swizzleMethod:@selector(viewDidDisappear:) withReplacement:JGMethodReplacementProviderBlock {
            return JGMethodReplacement(void, UIViewController *, BOOL animated) {
                JGOriginalImplementation(BOOL, animated);
                
                if ( [MBDebugPanel isPresented] ) {
                    [MBDebugPanel hide];
                }
                
                [MBDebugPanel removeComponentsInArray:self.mb_managedDebugPanelItems];
            };
        }];
    }
    else {
        [self deswizzleMethod:@selector(viewWillAppear:) ];
        [self deswizzleMethod:@selector(viewDidDisappear:) ];
    }

    objc_setAssociatedObject(self, MB_UIViewController_Utility_debugPanelItemsManagementEnabledKey, @(mb_debugPanelItemsManagementEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)mb_debugPanelItemsManagementEnabled
{
    BOOL result = NO;
    
    id boolObject = objc_getAssociatedObject(self, MB_UIViewController_Utility_debugPanelItemsManagementEnabledKey);

    if ( [boolObject isKindOfClass:[NSNumber class] ] ) {
        NSNumber *boolNumber = boolObject;
        result = [boolNumber boolValue];
    }
    
    return result;
}

- (BOOL)viewIsVisible
{
    return self.isViewLoaded && self.view.superview != nil;
}

- (void)mb_addManagedDebugPanelItems:(NSArray *)items
{
    if (self.mb_managedDebugPanelItems == nil) {
        self.mb_managedDebugPanelItems = [NSMutableArray arrayWithArray:items];
    }
    else {
        [self.mb_managedDebugPanelItems addObjectsFromArray:items];
    }
    
    if (self.mb_debugPanelItemsManagementEnabled && self.viewIsVisible) {
        [MBDebugPanel addComponentsFromArray:items];
    }
}

- (void)mb_removeManagedDebugPanelItems:(NSArray *)items
{
    [self.mb_managedDebugPanelItems removeObjectsInArray:items];
}

- (void)setMb_managedDebugPanelItems:(NSMutableArray *)managedDebugPanelItems
{
    objc_setAssociatedObject(self, MB_UIViewController_Utility_managedDebugPanelItemsKey, managedDebugPanelItems, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)mb_managedDebugPanelItems
{
    NSMutableArray *result;
    
    id itemsObject = objc_getAssociatedObject(self, MB_UIViewController_Utility_managedDebugPanelItemsKey);
    
    if ( [itemsObject isKindOfClass:[NSMutableArray class] ] ) {
        result = itemsObject;
    }
    
    return result;
}

- (void)mb_addDebugPanelGestureRecognizer:(UIGestureRecognizer *)recognizer
{
    [self mb_addDebugPanelGestureRecognizer:recognizer onView:self.view];
}

- (void)mb_addDebugPanelGestureRecognizer:(UIGestureRecognizer *)recognizer onView:(UIView *)view
{
    [recognizer addTarget:self action:@selector(mb_openDebugPanelFromGesture:) ];
    [view addGestureRecognizer:recognizer];
}

- (void)mb_addDebugPanelTapGestureRecognizer:(NSUInteger)numberOfTaps
{
    [self mb_addDebugPanelTapGestureRecognizer:numberOfTaps onView:self.view];
}

- (void)mb_addDebugPanelTapGestureRecognizer:(NSUInteger)numberOfTaps onView:(UIView *)view
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
