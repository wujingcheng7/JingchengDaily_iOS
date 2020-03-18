//
//  ListCell.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/18.
//  Copyright © 2020 吴京城. All rights reserved.
//

#import "ListCell.h"
#import "ListModel.h"
@interface ListCell()
@property(nonatomic, strong) UILabel *titleLabel;
@end
@implementation ListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI {
    //在这里创建UI元素
    //切记：  要使用[self.contentView addSubview:]  不要直接 [self addSubView:]  不然复用会有问题
    
}

- (void)setModel:(ListModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
