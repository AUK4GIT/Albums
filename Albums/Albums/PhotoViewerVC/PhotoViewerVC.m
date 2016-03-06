//
//  PhotoViewerVC.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "PhotoViewerVC.h"
#import "Helper.h"

@interface PhotoViewerVC ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotoViewerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Photo";
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicator.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.activityIndicator];
    [self.view bringSubviewToFront:self.activityIndicator];
    [self.activityIndicator hidesWhenStopped];
    self.activityIndicator.center = self.view.center;
    [self.activityIndicator startAnimating];
    [[Helper sharedInstance] fetchImageWithURLString:self.photoURL completionHandler:^(UIImage *image){
        self.imageView.image = image;
        [self.activityIndicator stopAnimating];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissVC:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
