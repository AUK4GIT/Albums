//
//  ThumbnailsVC.m
//  Albums
//
//  Created by Uday Kiran Ailapaka on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "ThumbnailsVC.h"
#import "ThumnailViewCell.h"
#import "Helper.h"
#import "Photos.h"
#import "PhotoViewerVC.h"

@interface ThumbnailsVC ()
@property(nonatomic, weak) Helper *helper;
@property(nonatomic, strong) NSArray *photos;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ThumbnailsVC

static NSString * const reuseIdentifier = @"ThumbnailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.tintColor = [UIColor darkGrayColor];
    [self.view addSubview:self.activityIndicator];
    [self.view bringSubviewToFront:self.activityIndicator];
    [self.activityIndicator hidesWhenStopped];
    self.activityIndicator.center = self.view.center;

    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    self.title = self.album.albumTitle;
    self.helper = [Helper sharedInstance];
    // Do any additional setup after loading the view.
    NSSet *pSet = [self.album valueForKey:@"photos"];
    NSLog(@"AlbumId: %ld  %d",(unsigned long)pSet.count, self.album.photos == NULL);
    if (pSet.count == 0) {
        [self fetchPhotosFromService];
    } else {
        self.photos = [pSet allObjects];
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)fetchPhotosFromService {
    [self.activityIndicator startAnimating];
    [self.helper fetchPhotosFromServiceForAlbumId:self.album.albumId.stringValue forAlbum:self.album completionHandler:^(NSArray * dbPhotos) {
        if (dbPhotos.count > 0) {
            self.photos = [NSArray arrayWithArray:dbPhotos];
            
//            NSSet *pSet = [self.album valueForKey:@"photos"];
//            NSLog(@"AlbumId: %ld  %d",pSet.count, self.album.photos == NULL);
//            if (pSet.count == 0) {
//                [self fetchPhotosFromService];
//            } else {
//                self.photos = [pSet allObjects];
//            }
            
            [self.collectionView reloadData];
        } else {
            //show Alert. No Albums found
        }
        [self.activityIndicator stopAnimating];
    }];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThumnailViewCell *cell = (ThumnailViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    // Configure the cell
    Photos *photo = (Photos *)self.photos[indexPath.row];
    [cell loadThumbNailWithURL:photo.photoThumbnailURL];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *pVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoViewerNVC"];
    pVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    PhotoViewerVC *nVC = (PhotoViewerVC *)pVC.visibleViewController;
    Photos *photo = (Photos *)self.photos[indexPath.item];
    nVC.photoURL = photo.photoURL;
    [self presentViewController:pVC animated:true completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIView *bgView = [cell viewWithTag:5.0];
//    bgView.alpha = 0;
//    bgView.transform = CGAffineTransformMakeScale(0.75, 0.75);
//    [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//     bgView.alpha = 1.0;
//        bgView.transform = CGAffineTransformIdentity;
//    } completion:nil];

}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


@end
