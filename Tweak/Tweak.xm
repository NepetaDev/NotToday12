#import "Tweak.h"

bool enabled = false;

%group NotToday12

%hook SBPagedScrollView

-(void)setPageViews:(NSArray *)views {
    NSMutableArray *newViews = [NSMutableArray new];
    for (SBDashBoardPageViewBase *view in views) {
        if ([view.pageViewController isKindOfClass:%c(SBDashBoardTodayPageViewController)]) {
            [view removeFromSuperview];
        } else {
            [newViews addObject:view];
        }
    }
    views = newViews;
    %orig(views);
}

%end

%hook SBHomeScreenTodayViewController

-(void)viewWillAppear:(bool)arg1 {
    %orig;
    [self.view removeFromSuperview];
}

%end

%hook SBRootFolderView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;

    if (scrollView.contentOffset.x < width) {
        [scrollView setContentOffset:CGPointMake(width, 0)];
    }

    %orig;
}

%end

%end

%ctor{
    NSLog(@"[NotToday12] init");

    #ifndef SIMULATOR
    HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"me.nepeta.nottoday12"];
    enabled = [([file objectForKey:@"Enabled"] ?: @(YES)) boolValue];
    #else
    enabled = true;
    #endif

    if (enabled) {
        %init(NotToday12);
    }
}
