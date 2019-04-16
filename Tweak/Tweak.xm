#import "Tweak.h"

#ifndef SIMULATOR
HBPreferences *preferences;
#endif
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

-(void)beginPageStateTransitionToState:(long long)arg1 animated:(BOOL)arg2 interactive:(BOOL)arg3  {
    if (enabled && arg1 == 2) return; // 0 - icons; 2 - today view; 3 - spotlight?
    %orig;
}

%end

%end

%ctor{
    NSLog(@"[NotToday12] init");
    #ifndef SIMULATOR
    preferences = [[HBPreferences alloc] initWithIdentifier:@"me.nepeta.nottoday12"];
    [preferences registerBool:&enabled default:YES forKey:@"Enabled"];
    #else
    enabled = YES;
    #endif
    %init(NotToday12);
}