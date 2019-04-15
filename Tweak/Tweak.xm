#import "Tweak.h"

bool enabled = false;

%group NotToday12

%hook SBMainDisplayPolicyAggregator

-(BOOL)_allowsCapabilityLockScreenTodayViewWithExplanation:(id*)arg1 {
    return false;
}

-(BOOL)_allowsCapabilityTodayViewWithExplanation:(id*)arg1 {
    return false;
}

%end

%hook SBRootFolderView

-(unsigned long long)_minusPageCount {
    return 0;
}

-(void)_layoutSubviewsForTodayView {
    %orig;
    [self todayViewController].view.alpha = 0.0;
    [self todayViewController].view.hidden = YES;
    [[self todayViewController].view removeFromSuperview];
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
