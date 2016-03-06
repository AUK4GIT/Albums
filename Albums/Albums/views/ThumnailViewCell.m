//
//  ThumnailViewCell.m
//  Albums
//
//  Created by Shravan Keri on 05/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "ThumnailViewCell.h"
#import "Helper.h"

@implementation ThumnailViewCell

- (void)loadThumbNailWithURL:(NSString *)urlString {
//    self.thumnailImageView.image = nil;
//    self.thumnailImageView.hidden = true;
    [[Helper sharedInstance] fetchImageWithURLString:urlString completionHandler:^(UIImage *image){
        self.thumnailImageView.image = image;
//        self.thumnailImageView.hidden = false;
    }];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
//    self.thumnailImageView.image = nil;
//    self.thumnailImageView.hidden = true;
}
@end
