//  I'ma Unicorn
//
//  Created by Franky Aguilar on 7/27/12.
//  Copyright (c) 2012 99centbrains Inc. All rights reserved.
//  @99centbrains - http://99centbrains.com
//  ALL ARTWORK AND DESIGN OWNED BY 99centbrains, not for reproduction or redistribution
//

#import <UIKit/UIKit.h>
#import "CWInAppHelper.h"

@class SelectStickerQuickViewController;

@protocol SelectStickerQuickViewControllerDelegate <NSObject>

-(void) selectStickerPackQuickViewController:(SelectStickerQuickViewController *)controller  didFinishPickingStickerImage:(UIImage *)image;

-(void) selectStickerQuickViewControllerDidCancel:(SelectStickerQuickViewController *)controller;

@end

@interface SelectStickerQuickViewController : UIViewController < UIScrollViewDelegate> {
    
    
}

@property (nonatomic, unsafe_unretained) id <SelectStickerQuickViewControllerDelegate> delegate;

@end
