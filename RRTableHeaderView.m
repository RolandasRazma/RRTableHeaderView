//
//  RRTableHeaderView.m
//
//  Created by Rolandas Razma on 7/3/12.
//  Copyright (c) 2012 Rolandas Razma. All rights reserved.
//

#import "RRTableHeaderView.h"


@implementation RRTableHeaderView {
    UIImageView *_backgroundImageView;
}


#pragma mark -
#pragma mark NSObject


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UITableView *)tableView change:(NSDictionary *)change context:(void *)context {
    
    CGRect imageViewFrame  = self.bounds;
    
    CGFloat offsetY = tableView.contentOffset.y *-1;
    
    if( offsetY > 0 && offsetY <= _backgroundImageView.image.size.height /2.0f ){
        imageViewFrame.size.height += offsetY;
        imageViewFrame.origin.y     = (self.bounds.size.height -imageViewFrame.size.height);
        
        [_backgroundImageView setFrame:imageViewFrame];
    }
    
}


#pragma mark -
#pragma mark UIView


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if( newSuperview == nil ){
        if( [self.superview isKindOfClass:[UITableView class]] ){
            [self.superview removeObserver:self forKeyPath:@"contentOffset"];
        }
    }else if( [newSuperview isKindOfClass:[UITableView class]] ){
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else{
        NSLog(@"RRTableHeaderView is designed to be used as UITableView header.");
    }
    
    [super willMoveToSuperview:newSuperview];
}


#pragma mark -
#pragma mark RRTableHeaderView


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if( !_backgroundImageView ){
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [_backgroundImageView setContentMode:UIViewContentModeCenter];
        [_backgroundImageView setClipsToBounds:YES];
        
        [self addSubview:_backgroundImageView];
        [_backgroundImageView release];
    }
    
    [_backgroundImageView setImage:backgroundImage];
    [self setBackgroundColor:[UIColor redColor]];
}


- (UIImage *)backgroundImage {
    return _backgroundImageView.image;
}


@end
