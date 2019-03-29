//
//  Mediator+MoudleTarger_B.h
//  compoent
//
//  Created by closureJan on 2019/3/29.
//  Copyright © 2019年 jian.yang. All rights reserved.
//

#import "Mediator.h"

@interface Mediator (MoudleTarger_B)

-(UIViewController *)gotoMoudleBControlerCompleteBlock:(void(^)(NSDictionary *))block;

@end
