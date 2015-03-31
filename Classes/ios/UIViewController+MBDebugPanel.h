//
//  UIViewController+MBDebugPanel.h
//  MBDebugPanel
//
//  Created by Ian on 3/27/15.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBDebugPanel)

@property (readwrite) BOOL mb_debugMenuItemsManagementEnabled;
- (void)mb_addManagedDebugMenuItems:(NSArray *)items;
- (void)mb_removeManagedDebugMenuItems:(NSArray *)items;

- (void)mb_addDebugMenuGestureRecognizer:(UIGestureRecognizer *)recognizer;
- (void)mb_addDebugMenuGestureRecognizer:(UIGestureRecognizer *)recognizer onView:(UIView *)view;

- (void)mb_addDebugMenuTapGestureRecognizer:(NSUInteger)numberOfTaps;
- (void)mb_addDebugMenuTapGestureRecognizer:(NSUInteger)numberOfTaps onView:(UIView *)view;

- (void)mb_openDebugPanel;

@end
