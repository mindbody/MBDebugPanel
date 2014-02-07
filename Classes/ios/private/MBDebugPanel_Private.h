//
//  MBDebugPanel_Private.h
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/11/14.
//
//

#import "MBDebugPanel.h"

@interface MBDebugPanel()
@property (nonatomic)               NSMutableArray *components;
@property (nonatomic, getter = isPresented) BOOL presented;
@property (nonatomic) UIViewController *wrappingViewController;
+(MBDebugPanel*)sharedPanel_;
@end
