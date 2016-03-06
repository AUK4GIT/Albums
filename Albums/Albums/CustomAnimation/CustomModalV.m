//
//  CustomModalV.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 06/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "CustomModalV.h"
#import "CustomPresentationVC.h"
#import "CustomAnimation.h"

@interface CustomModalV () <UIViewControllerTransitioningDelegate>

@end

@implementation CustomModalV

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    if (presented == self) {
//        return [[CustomAnimation alloc] init];
//    }
//    else {
//        return nil;
//    }
//}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    if (dismissed == self) {
//        return [[CustomAnimation alloc] init];
//    }
//    else {
//        return nil;
//    }
//}
//
//
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    if (presented == self) {
//        return [[CustomPresentationVC alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    }
//    return nil;
//}


@end
