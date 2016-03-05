//
//  ThumnailViewCell.h
//  Albums
//
//  Created by Shravan Keri on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumnailViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumnailImageView;
- (void)loadThumbNailWithURL:(NSString *)urlString;
@end
