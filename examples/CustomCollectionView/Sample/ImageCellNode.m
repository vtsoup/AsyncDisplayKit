//
//  ImageCellNode.m
//  Sample
//
//  Created by McCallum, Levi on 11/22/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "ImageCellNode.h"

@implementation ImageCellNode {
  ASImageNode *_imageNode;
  ASTextNode *_textNode;
}

- (id)initWithImage:(UIImage *)image
{
  self = [super init];
  if (self != nil) {
    self.backgroundColor = [UIColor blackColor];
    
    _imageNode = [[ASImageNode alloc] init];
    _imageNode.image = image;
    [self addSubnode:_imageNode];
    
    _textNode = [[ASTextNode alloc] init];
    _textNode.backgroundColor = [UIColor blackColor];
    _textNode.maximumNumberOfLines = 2;
    _textNode.attributedString = [[NSAttributedString alloc] initWithString:@"Photo description"
                                                                 attributes:[self textAttributes]];
    [self addSubnode:_textNode];
  }
  return self;
}

- (NSDictionary *)textAttributes
{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setAlignment:NSTextAlignmentCenter];
  
  return @{
           NSFontAttributeName: [UIFont systemFontOfSize:18.0],
           NSForegroundColorAttributeName: [UIColor whiteColor],
           NSParagraphStyleAttributeName: paragraphStyle
           };
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  constrainedSize = CGSizeMake(constrainedSize.width, constrainedSize.height - 100.0);
  [_imageNode measure:constrainedSize];
  
  CGFloat padding = 8.0;
  constrainedSize = CGSizeMake(_imageNode.calculatedSize.width - (2 * padding), constrainedSize.height);
  [_textNode measure:constrainedSize];

  CGSize trueSize = CGSizeMake(_imageNode.calculatedSize.width, _imageNode.calculatedSize.height + padding + _textNode.calculatedSize.height + padding);
  return trueSize;
}

- (void)layout
{
  [super layout];
  
  _imageNode.frame = CGRectMake(0, 0, _imageNode.calculatedSize.width, _imageNode.calculatedSize.height);
  
  CGFloat padding = 8.0;
  CGFloat textYPosition = CGRectGetMaxY(_imageNode.frame);
  _textNode.frame = CGRectMake(0, textYPosition + padding, _imageNode.calculatedSize.width, padding + _textNode.calculatedSize.height + padding);
  
}

@end
