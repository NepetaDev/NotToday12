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

%hook SBHomeScreenTodayViewController

-(void)viewWillAppear:(bool)arg1 {
    %orig;
    [self.view removeFromSuperview];
}

%end

%hook SBRootFolderView

-(unsigned long long)_minusPageCount {
    return 0;
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
