//
//  PersonCollectionViewCell.h
//  GroupTrack App
//
//  Created by Adam Goldberg on 2015-11-17.
//  Copyright © 2015 Adam Goldberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UILabel *personName;


@property (strong, nonatomic) IBOutlet UIImageView *personPicture;

@property (strong, nonatomic) IBOutlet UILabel *negativeLabel;

@property (strong, nonatomic) IBOutlet UILabel *positiveLabel;


@end
