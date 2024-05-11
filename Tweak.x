#import <UIKit/UIKit.h>
#import <Lottie/Lottie-Wrapper.h>
#import <rootless.h>

@interface CSCoverSheetViewController : UIViewController
@end

%hook CSCoverSheetViewController
- (void)viewDidLoad {
	%orig;

	// Define a path to your animation .json
	NSString *animationPath = ROOT_PATH_NS(@"/Library/Application Support/LottieExample/Pulse.json");

	// initialize LottieAnimationView
	LottieAnimationView *animationView = [[LottieAnimationView alloc] initWithFrame:self.view.frame];
	
	// load the animation with the path specified above
	[animationView loadAnimationWithPath:animationPath];

	[animationView setLoopMode:LottieLoopModeLoop];
	[animationView colorAnimation:[UIColor systemPinkColor] keypath:@"**.Color"];
	[animationView setAnimationSpeed:1.2];

	[self.view addSubview:animationView];

	// This is the completion block that will be called when the animation is finished
	[animationView playWithCompletion:^(BOOL finished) {
		NSLog(@"[Lottie-Bridging-Example] Animation Finished");

		[UIView animateWithDuration:0.5 animations:^{
			animationView.alpha = 0;
		} completion:^(BOOL finished) {
			[animationView removeFromSuperview];
		}];
	}];

	// Add a tap gesture to stop the animation
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
	[animationView addGestureRecognizer:tapGesture];
}

%new
- (void)tapGesture:(UITapGestureRecognizer *)sender {
	NSLog(@"[Lottie-Bridging-Example] Tapped");
	LottieAnimationView *animationView = (LottieAnimationView *)sender.view;
	[animationView stop];
}
%end