#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIControl.h>

#ifndef SIMULATOR
#import <Cephei/HBPreferences.h>
#endif

@interface SBDashBoardPageViewBase : UIView

@property (nonatomic,retain) UIViewController *pageViewController;

@end

@interface SBHomeScreenTodayViewController : UIViewController

@end

@interface SBIconScrollView : UIView

@end

@interface _SBRootFolderLayoutWrapperView : UIView

@end

@interface SBIconListPageControl : UIView

@property (nonatomic, retain) UIView *ntFirst;

@end