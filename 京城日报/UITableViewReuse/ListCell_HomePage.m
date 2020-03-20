//
//  ListCell_HomePage.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//
#import "ListCell_HomePage.h"
#import "ListModel_HomePage.h"

@implementation ListCell_HomePage
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andModel:(ListModel_HomePage*) model{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
        [self setModel:model];
    }
    return self;
}
- (void)layoutUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //在这里创建UI元素
    //切记：  要使用[self.contentView addSubview:]  不要直接 [self addSubView:]  不然复用会有问题
    self.accessoryType = UITableViewCellAccessoryDetailButton;//右边图片
    self.selectionStyle = UITableViewCellSelectionStyleNone;//点击不变色
    
}

- (void)setModel:(ListModel_HomePage *)model {
    _model = model;
    _model.title = model.title;
    _model.author = model.author;
    _model.imgName = model.imgName;
    _model.webUrl = model.webUrl;
    //改变显示内容
    self.textLabel.text = model.title;
    self.detailTextLabel.text = [NSString stringWithFormat:@"作者/%@",model.author];
    UIImage *img = [UIImage imageNamed:model.imgName];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 66, 66);
    self.accessoryView = imgView;
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
