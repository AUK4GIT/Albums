//
//  CustomAnimation.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 06/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation
{
    BOOL isPresenting;
    NSTimeInterval duration;
}

- (id)init{
    if (self=[super init]) {
        isPresenting = true;
        duration = 0.5;
    }
    return self;
}

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return duration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (isPresenting) {
        [self animatePresentationWithTransitionContext:transitionContext];
    }
    else {
        [self animateDismissalWithTransitionContext:transitionContext];
    }
}

// ---- Helper methods

- (void)animatePresentationWithTransitionContext:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
//    guard
//    let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
//    let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
//    let containerView = transitionContext.containerView()
//    else {
//        return
//    }
//    
//    // Position the presented view off the top of the container view
//    presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
//    //        presentedControllerView.center.y -= containerView.bounds.size.height
//    presentedControllerView.alpha = 0.0;
//    containerView.addSubview(presentedControllerView)
//    
//    // Animate the presented view to it's final position
//    UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
//        //            presentedControllerView.center.y += containerView.bounds.size.height
//        presentedControllerView.alpha = 1.0;
//    }, completion: {(completed: Bool) -> Void in
//        transitionContext.completeTransition(completed)
//    })
}

- (void)animateDismissalWithTransitionContext:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
//    guard
//    let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey),
//    let containerView = transitionContext.containerView()
//    else {
//        return
//    }
//    
//    // Animate the presented view off the bottom of the view
//    UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
//        //            presentedControllerView.center.y += containerView.bounds.size.height
//        presentedControllerView.alpha = 0.0;
//    }, completion: {(completed: Bool) -> Void in
//        transitionContext.completeTransition(completed)
//    })
}

@end
