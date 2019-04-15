#import "Tweak.h"

HBPreferences *preferences;
bool enabled;

%group NotToday12

%hook SBMainDisplayPolicyAggregator

-(BOOL)_allowsCapabilityLockScreenTodayViewWithExplanation:(id*)arg1 {
    return !enabled;
}

-(BOOL)_allowsCapabilityTodayViewWithExplanation:(id*)arg1 {
    return !enabled;
}

%end

%hook SBRootFolderView

-(unsigned long long)_minusPageCount {
    return !enabled;
}

-(void)_layoutSubviewsForTodayView {
    %orig;
    [self todayViewController].view.hidden = enabled;
}

%end

%end

%ctor{
    NSLog(@"[NotToday12] init");
    preferences = [[HBPreferences alloc] initWithIdentifier:@"me.nepeta.nottoday12"];
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    %init(NotToday12);
}