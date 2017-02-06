//
//  UIViewController+MBDebugPanel.h
//  MBDebugPanel
//
//  Created by Ian on 3/27/15.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBDebugPanel)

@property (readwrite) BOOL mb_debugPanelItemsManagementEnabled;
- (void)mb_addManagedDebugPanelItems:(NSArray *)items;
- (void)mb_removeManagedDebugPanelItems:(NSArray *)items;

- (void)mb_addDebugPanelGestureRecognizer:(UIGestureRecognizer *)recognizer;
- (void)mb_addDebugPanelGestureRecognizer:(UIGestureRecognizer *)recognizer onView:(UIView *)view;

- (void)mb_addDebugPanelTapGestureRecognizer:(NSUInteger)numberOfTaps;
- (void)mb_addDebugPanelTapGestureRecognizer:(NSUInteger)numberOfTaps onView:(UIView *)view;

- (void)mb_openDebugPanel;

@end
