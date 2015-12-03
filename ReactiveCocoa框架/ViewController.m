//
//  ViewController.m
//  ReactiveCocoa框架
//
//  Created by apple on 15/10/18.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

#import "ReactiveCocoa.h"
#import "Flag.h"
@interface ViewController ()

/**  */
@property (nonatomic, strong) NSArray *flags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // RAC:集合,相当于数组或者字典
    // 这个类的创建必须要依赖于数组或者字典
    // 解析plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    _flags = [NSMutableArray array];
    
//    [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
//        Flag *flag =  [Flag flagWithDict:x];
//        [_flags addObject:flag];
//    }];
    
    
   _flags = [[dictArr.rac_sequence map:^id(id value) {
        // value:就是原始信号发送的值,字典
        // block返回值就是需要映射的对象
        return [Flag flagWithDict:value];
    }] array];
    NSLog(@"%@",_flags);
    
    
}
- (void)dict
{
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //        id value = x[1];
        //        id key = x[0];
        
        // 宏的参数,存放需要生成的变量名
        // 宏会自动生成参数里面的变量
        RACTupleUnpack(id key,id value) = x;
        
        NSLog(@"%@ : %@",key,value);
    }];

}

- (void)arr
{
    NSArray *arr = @[@"123",@1,@3,@5];
    
    // OC数组转换成RAC集合
    RACSequence *sequence = arr.rac_sequence;
    
    // 把集合转换成signal
    RACSignal *signal = sequence.signal;
    
    // 订阅集合类的信号,只要订阅这个信号,就会遍历集合中所有元素
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

}

- (void)RACTuple
{
    // RACTuple:元组,NSArray
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"123",@1,@3,@5]];
    NSString *str = tuple[0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
