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