//
//  CustomPresentationVC.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 06/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "CustomPresentationVC.h"

@implementation CustomPresentationVC

- (void)presentationTransitionWillBegin {
    
    UIView *containerView = [self containerView];
    UIView *presentedView = [self presentedView];
    
    [containerView addSubview:presentedView];
    
    if (self.presentingViewController.transitionCoordinator != nil) {
        [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            containerView.alpha = 1.0;
        } completion:nil];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
    }
}

- (void)dismissalTransitionWillBegin {
    UIView *containerView = [self containerView];
    if (self.presentingViewController.transitionCoordinator != nil) {
        [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            containerView.alpha = 0.0;
        } completion:nil];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    return self.containerView.frame;
}

@end
