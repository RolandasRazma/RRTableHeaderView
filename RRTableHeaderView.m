//
//  RRTableHeaderView.m
//
// Copyright (c) 2012 Rolandas Razma <rolandas@razma.lt>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        
        [self insertSubview:_backgroundImageView atIndex:0];
#if !__has_feature(objc_arc)
        [_backgroundImageView release];
#endif
    }
    
    [_backgroundImageView setImage:backgroundImage];
}


- (UIImage *)backgroundImage {
    return _backgroundImageView.image;
}


@end
