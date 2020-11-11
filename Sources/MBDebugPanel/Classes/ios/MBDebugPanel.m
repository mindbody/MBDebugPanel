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
//  MBDebugPanel.m
//  MBDebugPanel
//
//  Created by Matthew Holden on 2/6/14.
//
//

#import "MBDebugPanel.h"
#import "MBDebugPanel_Private.h"

@implementation MBDebugPanel
+(MBDebugPanel*)sharedPanel_
{
    static dispatch_once_t onceToken;
    static MBDebugPanel *inst;
    dispatch_once(&onceToken, ^{
        inst = [self.class new];
        [inst setComponents:[NSMutableArray new]];
    });
    return inst;
}

+ (NSBundle *)bundle
{
#ifdef SWIFTPM_MODULE_BUNDLE
    return SWIFTPM_MODULE_BUNDLE;
#else
    return [NSBundle bundleForClass:self];
#endif
}

+(void)addComponent:(id<MBDebugPanelComponent>)component
{
    [self.sharedPanel_.components addObject:component];
}
+(void)removeComponent:(id<MBDebugPanelComponent>)component
{
    [self.sharedPanel_.components removeObject:component];
}
+(void)removeAllComponents
{
    [self.sharedPanel_.components removeAllObjects];
}
+(void)addComponentsFromArray:(NSArray*)components
{
    [self.sharedPanel_.components addObjectsFromArray:components];
}
+(void)removeComponentsInArray:(NSArray*)components
{
    [self.sharedPanel_.components removeObjectsInArray:components];
}
+(void)show
{
    [self.sharedPanel_ showInNewNavigationController_];
}
+(void)hide
{
    [self.sharedPanel_ dismiss_];
}
+(void)reloadComponents
{
    [self.sharedPanel_.tableView reloadData];
}
+(BOOL)isPresented
{
    return [MBDebugPanel.sharedPanel_ isPresented];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^ __nullable)(void))completion {
    
    [[MBDebugPanel.sharedPanel_ wrappingViewController] presentViewController:viewControllerToPresent
                                                                     animated:flag
                                                                   completion:completion];
}

+ (void)setTitle:(NSString*)title
{
    [MBDebugPanel.sharedPanel_ setTitle:title];
}

#pragma mark UITableViewDataSource/Delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MBDebugPanelComponent> component = [self componentForRowAtIndexPath_:indexPath];
    return [component cellForDisplayInTableView:self.tableView atIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MBDebugPanelComponent> component = [self componentForRowAtIndexPath_:indexPath];
    return [component cellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.class sharedPanel_] components] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark private / helpers
-(void)showInNewNavigationController_
{
    [self configureForDisplayInNavigationController_];
    [self.tableView reloadData];

    UINavigationController *wrapper = [[UINavigationController alloc] initWithRootViewController:self];
    [self setWrappingViewController:wrapper];
    UIView *navigationView = [wrapper view];
    [navigationView setFrame:[[UIScreen mainScreen] bounds]];

    UIView *rootView = [[UIApplication sharedApplication] keyWindow];
    [rootView addSubview:navigationView];
}

-(void)configureForDisplayInNavigationController_
{
    UIBarButtonItem *doneButton
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                    target:self
                                                    action:@selector(doneBarButtonTapped_:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

-(void)dismiss_
{
    if (self.wrappingViewController) {
        if (self.navigationController) {
            [self.navigationController setViewControllers:@[] animated:NO];
        }

        UIView *wrappingView = self.wrappingViewController.view;
        [wrappingView removeFromSuperview];
        self.wrappingViewController = nil;
    }
}

-(void)doneBarButtonTapped_:(id)sender
{
    [MBDebugPanel hide];
}

-(id<MBDebugPanelComponent>)componentForRowAtIndexPath_:(NSIndexPath*)indexPath
{
    return [[self.class sharedPanel_] components][indexPath.row];
}

-(BOOL)isPresented
{
    return !![[self.class sharedPanel_] parentViewController];
}
@end
