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
    [[Helper sharedInstance] fetchImageWithURLString:urlString completionHandler:^(UIImage *image){
        self.thumnailImageView.image = image;
    }];
}
@end
