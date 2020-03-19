//
//  ListCell_FirstSection.m
//  京城日报
//
//  Created by 吴京城 on 2020/3/19.
//  Copyright © 2020 吴京城. All rights reserved.
//
#import "ListCell_FirstSection.h"
#import "ListModel_FirstSection.h"
@implementation ListCell_FirstSection

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutUI];
    }
    return self;
}
-(void)layoutUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //加载view
    if (self.model.subtitle!=nil) {//大字号选项有副标题，其他没有
        self.textLabel.text = self.model.title;
        self.detailTextLabel.text = self.model.subtitle;
        if(self.accessoryView == nil){
            UISwitch *s = [[UISwitch alloc]init];
            self.accessoryView = s;
        }
    }else{//没有副标题的情况即为其他选项
        self.textLabel.text = self.model.title;
        if (self.model.webUrl!=nil) {//有链接的则包含➡️箭头
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([self.textLabel.text isEqualToString:@"清除缓存"]) {
            UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
            l.textAlignment = NSTextAlignmentCenter;
            l.text = @"3.75M";//这里应该获取缓存量
            self.accessoryView = l;
        }
    }
}

-(void)setModel:(ListModel_FirstSection *)model{
    _model = model;
    _model.title = model.title;
    _model.subtitle = model.subtitle;
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
