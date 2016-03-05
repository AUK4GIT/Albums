//
//  ViewController.m
//  Albums
//
//  Created by Shravan Keri on 04/03/16.
//  Copyright © 2016 Shravan Keri. All rights reserved.
//

#import "AlbumListsViewController.h"
#import "ThumbnailsVC.h"
#import "Helper.h"
#import "Albums.h"

@interface AlbumListsViewController ()
@property(nonatomic, strong) NSArray *albums;
@property(nonatomic, weak) Helper *helper;
@end

@implementation AlbumListsViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Albums";

    self.tableView.rowHeight = 64;
    
    self.helper = [Helper sharedInstance];
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(fetchAlbumsFromService)
                  forControlEvents:UIControlEventValueChanged];
    
    [self fetchAlbumsFromDB];
}

- (void)fetchAlbumsFromService {
    
    [self.helper fetchAlbumsFromService:^(NSArray *dbAlbums){
        if (dbAlbums.count > 0) {
            self.albums = dbAlbums;
            [self.tableView reloadData];
        } else {
            //show Alert. No Albums found
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)fetchAlbumsFromDB {
    
    [self.helper fetchAlbumsFromDB:^(NSArray *dbAlbums) {
        if (dbAlbums.count > 0) {
            self.albums = dbAlbums;
            [self.tableView reloadData];
        } else {
            [self fetchAlbumsFromService];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Thumbnail"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Albums *album = (Albums *)[self.albums objectAtIndex:path.row];
        ThumbnailsVC *destVC = segue.destinationViewController;
        destVC.album = album;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"AlbumList" forIndexPath:indexPath];
    
    Albums *album = (Albums *)[self.albums objectAtIndex:indexPath.row];
    cell.textLabel.text = album.albumTitle;
    cell.detailTextLabel.text = album.userName;

    return cell;
}
@end
